abstract class TodoeyStates {}

class TodoeyInitialState extends TodoeyStates {}

//------------------------------<Toggle Checkbox>----------------------------------

class ToggleCheckboxState extends TodoeyStates {}

//------------------------------<Get Tasks>----------------------------------

class GetTasksSuccessState extends TodoeyStates {}

//-------------------------------<Delete Tasks>------------------------------------------
class DeleteSuccessState extends TodoeyStates {}

class DeleteErrorState extends TodoeyStates {}
