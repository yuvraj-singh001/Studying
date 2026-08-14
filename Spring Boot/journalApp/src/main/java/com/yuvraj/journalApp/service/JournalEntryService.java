package com.yuvraj.journalApp.service;

import com.yuvraj.journalApp.entity.JournalEntry;
import com.yuvraj.journalApp.entity.User;
import com.yuvraj.journalApp.repository.JournalEntryRepository;
import lombok.extern.slf4j.Slf4j;
import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Component
@Slf4j
public class JournalEntryService {

    @Autowired
    private JournalEntryRepository journalEntryRepository;
    @Autowired
    private UserService userService;

    @Transactional
    public void saveEntry(JournalEntry journalEntry, String userName){
        try{
            User user = userService.findByUserName(userName);
            journalEntry.setDate(LocalDateTime.now());
            JournalEntry save = journalEntryRepository.save(journalEntry);
            user.getJournalEntries().add(save);
            userService.saveEntry(user);
        }
        catch(Exception e){
            log.error("Exception", e);
            throw e;
        }
    }

    public void saveEntry(JournalEntry journalEntry){
        journalEntryRepository.save(journalEntry);
    }

    public List<JournalEntry> getAll(){
        return journalEntryRepository.findAll();
    }

    public Optional<JournalEntry> findById(ObjectId id){
        return journalEntryRepository.findById(id);
    }

    @Transactional
    public void deleteById(ObjectId id, String userName){
        User user = userService.findByUserName(userName);
        if(user != null){
            user.getJournalEntries().removeIf(x -> x.getId().equals(id));
            userService.saveEntry(user);
            journalEntryRepository.deleteById(id);
        }
    }
}

//controller ---> service --> repository (call)