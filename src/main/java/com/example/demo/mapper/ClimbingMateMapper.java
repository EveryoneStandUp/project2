package com.example.demo.mapper;

import java.util.*;

import org.apache.ibatis.annotations.*;

import com.example.demo.domain.*;

@Mapper
public interface ClimbingMateMapper {

	@Insert("""
			INSERT INTO ClimbingMate (title, body, writer, Lat, Lng, time)
			VALUES (#{title}, #{body}, #{writer}, #{Lat}, #{Lng}, #{time})
			""")
	@Options(useGeneratedKeys = true, keyProperty = "id")
	int insert(ClimbingMate climbingMate);

	@Select("""
			SELECT * FROM ClimbingMate
			ORDER BY Id DESC;
			""")
	List<ClimbingMate> selectList();

	@Select("""
			SELECT
			    c.id,
			    c.title,
			    c.body,
			    c.inserted,
			    c.writer,
			    c.Lat,
			    c.Lng,
			    c.people,
			    m.userId,
			    COUNT(cp.boardId) AS currentNum
			FROM
			    ClimbingMate c
			    LEFT JOIN ClimbingParty cp ON c.id = cp.boardId
			    LEFT JOIN Member m ON c.writer = m.nickName
			WHERE
			    c.id = #{id}
			GROUP BY
			    c.id,
			    c.title,
			    c.body,
			    c.inserted,
			    c.writer,
			    c.Lat,
			    c.Lng,
			    c.people;
			""")
	@ResultMap("climbingMateResultMap")
	ClimbingMate selectById(Integer id);

	@Select("""
			select
			   c.id,
			   c.title,
			   c.body,
			   c.writer,
			   c.inserted,
			   c.Lat,
			   c.Lng,
			   c.people
			   FROM ClimbingMate c
			   where b.writer = #{writer}
			""")
	@ResultMap("climbingMateResultMap")
	List<ClimbingMate> selectMyPageInfo(String writer);

	@Select("""
			select boardId ,memberId
			from ClimbingParty p left join ClimbingMate c ON p.boardId = c.id
			where userId = #{writer}
			""")
	List<ClimbingParty> selectMemberId(String writer);

	@Select("""
			select boardId ,memberId
			from ClimbingParty p left join ClimbingMate c ON p.boardId = c.id
			where userId = #{writer} and boardId = #{boardId}
			""")
	List<ClimbingParty> selectMemberIdByBoardId(Integer boardId, String writer);
	
	@Select("""
			SELECT
			    c.id,
			    c.title,
			    c.body,
			    c.inserted,
			    c.writer,
			    c.Lat,
			    c.Lng,
			    c.people,
			    COUNT(cp.boardId) AS currentNum
			FROM
			    ClimbingMate c
			    LEFT JOIN ClimbingParty cp ON c.id = cp.boardId
			GROUP BY
			    c.id,
			    c.title,
			    c.body,
			    c.inserted,
			    c.writer,
			    c.Lat,
			    c.Lng,
			    c.people
			""")
	@ResultMap("climbingMateResultMap")
	List<ClimbingMate> selectMate();

	@Delete("""
			DELETE FROM ClimbingMateFileName
			WHERE mateId = #{mateId}
				AND fileName = #{fileName}
			""")
	void deleteFileNameByBoardIdAndFileName(Integer id, String fileName);

	@Insert("""
			INSERT INTO FileName (mateId, fileName)
			VALUES (#{mateId}, #{fileName})
			""")
	void insertFileName(Integer id, String originalFilename);

	@Update("""
			UPDATE ClimbingMate
			SET
				title = #{title},
				body = #{body}
			WHERE
				id = #{id}
			""")
	int update(ClimbingMate climbingMate);

	@Select("""
			SELECT fileName FROM ClimbingMateFileName
			WHERE mateId = #{mateId}
			""")
	List<String> selectFileNamesBymateId(Integer id);

	@Delete("""
			DELETE FROM ClimbingMateFileName
			WHERE mateId = #{mateId}
				AND fileName = #{fileName}
			""")
	void deleteFileNameBymateId(Integer id);

	@Delete("""
			DELETE FROM ClimbingMate
			WHERE id = #{id}
			""")
	int deleteById(Integer id);

	@Select("""
			SELECT fileName FROM ClimbingMateFileName
			WHERE mateId = #{mateId}
			""")
	List<String> selectFileNamesByBoardId(Integer id);

	@Delete("""
			DELETE FROM ClimbingMateFileName
			WHERE mateId = #{mateId}
				AND fileName = #{fimeName}
			""")
	void deleteFileNameByMateId(Integer id);

	@Select("""
	select boardId ,memberId
	from ClimbingParty p left join ClimbingBoard b ON p.boardId = b.id
	""")
	List<ClimbingParty> selectMember();

	@Select("""
			SELECT * FROM ClimbingMate
			WHERE title LIKE '%${searchTerm}%'
			""")
	List<ClimbingMate> selectBySearchTerm(String searchTerm);

	@Select("""
			select * from Member where userId = #{userId}
			""")
	List<Member> selectUserId(String userId);

	@Select("""
			select p.boardId , p.memberId, p.userId
			from ClimbingParty p left join RunningBoard b ON p.boardId = b.id
			where boardId = #{boardId} group by p.boardId, p.memberId;
						""")
	List<ClimbingParty> selectForMemberIdByBoardId(Integer boardId);

	@Select("""
			select * from Member where userId = #{userId}
			""")
	Member getNickName(String name);



}