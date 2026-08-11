package com.yuvraj.journalApp.controller;

import com.yuvraj.journalApp.entity.JournalEntry;
import com.yuvraj.journalApp.entity.User;
import com.yuvraj.journalApp.service.JournalEntryService;
import com.yuvraj.journalApp.service.UserService;
import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.*;

@RestController
@RequestMapping("/journal")
public class JournalEntryControllerV2 {

    @Autowired
    private JournalEntryService journalEntryService;

    @Autowired
    private UserService userService;

    @GetMapping("/{userName}")
    public ResponseEntity<List<JournalEntry>> getAllJournalEntriesOfUser(@PathVariable String userName) {
        User user = userService.findByUserName(userName);

        if(user != null){
            List<JournalEntry> all = user.getJournalEntries();
            if(!all.isEmpty()){
                return new ResponseEntity<>(all, HttpStatus.OK);
            }
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
    }


    @PostMapping("/single/{userName}")
    public ResponseEntity<JournalEntry> createEntry(@PathVariable String userName, @RequestBody JournalEntry myEntry) {
        try{
            journalEntryService.saveEntry(myEntry, userName);
            return new ResponseEntity<>(myEntry, HttpStatus.CREATED);
        }
        catch (Exception e){
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }


    @PostMapping("/multi/{userName}")
    public ResponseEntity<List<JournalEntry>> createEntry(@PathVariable String userName, @RequestBody List<JournalEntry> myEntry) {
        try{
            for(JournalEntry journalEntry : myEntry){
                journalEntry.setDate(LocalDateTime.now());
                journalEntryService.saveEntry(journalEntry, userName);
            }
            return new ResponseEntity<>(myEntry, HttpStatus.CREATED);
        }
        catch (Exception e){
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }


    @GetMapping("/id/{myId}")
    public ResponseEntity<?> getJournalEntry(@PathVariable ObjectId myId) {
        Optional<JournalEntry> journalEntry = journalEntryService.findById(myId);
        if(journalEntry.isPresent()){
            return new ResponseEntity<> (journalEntry.get(), HttpStatus.OK);
        }
        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
    }


    @DeleteMapping("/id/{userName}/{myId}")
    public ResponseEntity<?> deleteJournalEntry(@PathVariable String userName, @PathVariable ObjectId myId) {
        journalEntryService.deleteById(myId, userName);
        return new ResponseEntity<>(HttpStatus.OK);
    }


//    @PutMapping("/id/{myId}")
//    public ResponseEntity<?> updateJournalEntry(@PathVariable ObjectId myId, @RequestBody JournalEntry newEntry) {
//        JournalEntry old = journalEntryService.findById(myId).orElse(null);
//        if(old != null){
////            if(newEntry.getTitle() != null && newEntry.getTitle().length() > 0) old.setTitle(newEntry.getTitle());
////            else old.setTitle(old.getTitle());
////
////            if(newEntry.getContent() != null && newEntry.getContent().length() > 0) old.setContent(newEntry.getContent());
////            else old.setContent(old.getContent());
//
//            old.setTitle(newEntry.getTitle() != null && !newEntry.getTitle().isEmpty() ? newEntry.getTitle() : old.getTitle());
//            old.setContent(newEntry.getContent() != null && !newEntry.getContent().isEmpty() ? newEntry.getContent() : old.getContent());
//            journalEntryService.saveEntry(old, userName);
//            return new ResponseEntity<>(HttpStatus.OK);
//        }
//        return  new ResponseEntity<>(HttpStatus.NOT_FOUND);
//    }
}


//    This is for sending multiple entries in same time
//    @PostMapping
//    public boolean createEntry(@RequestBody List<JournalEntry> myEntry){
//        for(JournalEntry entry : myEntry){
//            journalEntries.put(entry.getId(), entry);
//        }
//        return true;
//    }