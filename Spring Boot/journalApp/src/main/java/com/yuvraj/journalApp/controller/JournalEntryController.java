//package com.yuvraj.journalApp.controller;
//
//import com.yuvraj.journalApp.entity.JournalEntry;
//import org.springframework.web.bind.annotation.*;
//
//import java.util.ArrayList;
//import java.util.HashMap;
//import java.util.List;
//import java.util.Map;
//
//@RestController
//@RequestMapping("/_journal")
//public class JournalEntryController {
//
//    private Map<String, JournalEntry> journalEntries = new HashMap<>();
//
//    @GetMapping
//    public List<JournalEntry> getAll(){
//        return new ArrayList<>(journalEntries.values());
//    }
//
//    @PostMapping("/single")
//    public boolean createEntry(@RequestBody JournalEntry myEntry){
//        journalEntries.put(myEntry.getId(), myEntry);
//        return true;
//    }
//
//    @PostMapping("/multi")
//    public boolean createEntry(@RequestBody List<JournalEntry> myEntry){
//        for(JournalEntry entry : myEntry){
//            journalEntries.put(entry.getId(), entry);
//        }
//        return true;
//    }
//
//    @GetMapping("/id/{myId}")
//    public JournalEntry getJournalEntry(@PathVariable String myId){
//        return journalEntries.get(myId);
//    }
//
//    @DeleteMapping("/id/{myId}")
//    public boolean deleteJournalEntry(@PathVariable String myId){
//        journalEntries.remove(myId);
//        return true;
//    }
//
//    @PutMapping("/id/{myId}")
//    public boolean updateJournalEntry(@PathVariable String myId, @RequestBody JournalEntry myEntry){
//        journalEntries.put(myId, myEntry);
//        return true;
//    }
//}
//
//
//
//
////    This is for sending multiple entries in same time
////    @PostMapping
////    public boolean createEntry(@RequestBody List<JournalEntry> myEntry){
////        for(JournalEntry entry : myEntry){
////            journalEntries.put(entry.getId(), entry);
////        }
////        return true;
////    }