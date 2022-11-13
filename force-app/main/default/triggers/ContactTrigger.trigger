trigger ContactTrigger on Contact (after insert,after update) {

    //TODO: implement custom setting to dual sync or not
    if(Trigger.isUpdate){

        System.enqueueJob(new LightspeedCustomerUpdateQueueable(Trigger.new));

    }else if(Trigger.isInsert){
        
        System.enqueueJob(new LightspeedCustomerInsertQueueable(Trigger.new));

    }
}