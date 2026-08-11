package com.yuvraj.journalApp.repository;

import com.yuvraj.journalApp.entity.JournalEntry;
import com.yuvraj.journalApp.entity.User;
import org.bson.types.ObjectId;
import org.springframework.data.mongodb.repository.MongoRepository;


public interface UserRepository extends MongoRepository<User, ObjectId> {

    User findByUserName(String userName);

    void deleteByUserName(User user);
}
