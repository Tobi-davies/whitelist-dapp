// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Todo {
    struct Task {
        string title;
        string description;
        bool isCompleted;
    }
    mapping(uint => Task) public todos;
    Task[] public todosArray;
    // Task[] public completedTodos;
    uint ID;
    uint[] id;


    function addTodo (string memory _title, string memory _desc) public {
        Task storage task = todos[ID];
        task.title = _title;
        task.description = _desc;
        uint _id = ID;
        id.push(_id);
        ID++;

    }

    function markAsDone (uint _id) public {
          Task storage task = todos[_id];
          task.isCompleted = !task.isCompleted;
    }

    function deletetTodo (uint _id) public {
//  Task storage task = todos[_id];
//         delete task;

    delete todos[_id];
 }
     function getAllTodos() public view returns(Task[] memory _todosArray){
        uint[] memory all = id;
        _todosArray = new Task[](all.length);

        for(uint i; i < all.length; i++){
            _todosArray[i] = todos[all[i]];
        }
    } 

    


}