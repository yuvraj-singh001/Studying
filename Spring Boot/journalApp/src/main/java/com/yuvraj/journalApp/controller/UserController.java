package com.yuvraj.journalApp.controller;

import com.yuvraj.journalApp.entity.User;
import com.yuvraj.journalApp.service.UserService;
import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    @GetMapping
    public ResponseEntity<?> getAllUsers(){
        List<User> all = userService.getAll();
        if(!all.isEmpty()){
            return new ResponseEntity<>(all, HttpStatus.OK);
        }
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }


    @PostMapping
    public ResponseEntity<?> addUser(@RequestBody User user){
        try{
            userService.saveEntry(user);
            return new ResponseEntity<>(true ,HttpStatus.CREATED);
        }
        catch(Exception e){
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }

    @GetMapping("/Un/{userName}")
    public ResponseEntity<User> getUserById(@PathVariable String userName){
        User user = userService.findByUserName(userName);

        if(user != null){
            return new ResponseEntity<>(user,HttpStatus.OK);
        }
        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
    }

    @DeleteMapping("/Un/{userName}")
    public ResponseEntity<?> deleteUserById(@PathVariable String userName){
        User user = userService.findByUserName(userName);
        if(user != null){
            userService.deleteByUserName(user);
            return new ResponseEntity<>(true, HttpStatus.OK);
        }
        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
    }

    @PutMapping("/byUn/{userName}")
    public ResponseEntity<?> updateUser(@PathVariable String userName , @RequestBody User user){
        User userInDb = userService.findByUserName(userName);
        if(userInDb != null){
//            userInDb.setUserName(user.getUserName());
            userInDb.setPassword(user.getPassword());
            userService.saveEntry(userInDb);
            return new ResponseEntity<>(HttpStatus.OK);
        }
        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
    }
}