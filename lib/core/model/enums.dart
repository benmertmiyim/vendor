enum Status{
  completed,
  canceled,
  approval,
  processing,
  payment,
}

statusConvert(String status){
  switch(status){
    case "completed":
      return Status.completed;
    case "canceled":
      return Status.canceled;
    case "approval":
      return Status.approval;
    case "processing":
      return Status.processing;
    case "payment":
      return Status.payment;
  }
}

statusConvert2(Status status){
  switch(status){
    case Status.completed:
      return "completed";
    case Status.canceled:
      return "canceled";
    case Status.approval:
      return "approval";
    case Status.processing:
      return "processing";
    case Status.payment:
      return "payment";
  }
}
