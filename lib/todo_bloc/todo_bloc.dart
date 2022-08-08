import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test1/model/todo_model.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitialState()) {
    on<LoadTodoEvent>(_onLoadTodoEvent);
    on<AddTodoEvent>(_onAddTodoEvent);
    on<UpdateTodoEvent>(_onUpdateTodoEvent);
    on<DeleteTodoEvent>(_onDeleteTodoEvent);
  }
  _onLoadTodoEvent(LoadTodoEvent event, Emitter<TodoState> emit) {
    emit(TodoLoadedState(todos: event.todos));
  }

  _onAddTodoEvent(AddTodoEvent event, Emitter<TodoState> emit) {
    if (state is TodoLoadedState) {
      final state = this.state as TodoLoadedState;
      emit(
        TodoLoadedState(todos: List.from(state.todos)..add(event.todo)),
      );
    }
  }

  _onUpdateTodoEvent(UpdateTodoEvent event, Emitter<TodoState> emit) {}

  _onDeleteTodoEvent(DeleteTodoEvent event, Emitter<TodoState> emit) {
    if (state is TodoLoadedState) {
      final state = this.state as TodoLoadedState;
      emit(
        TodoLoadedState(todos: List.from(state.todos)..remove(event.todo)),
      );
    }
  }
}
