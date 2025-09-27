class QueueNode inherits Object {
    item : Object;    -- 节点存储的数据
    next : QueueNode; -- 指向队列中的下一个节点
    
    -- 初始化节点
    init(i : Object, n : QueueNode) : QueueNode {
        {
            item <- i;
            next <- n;
            self;
        }
    };
    
    -- 返回节点的数据
    getItem() : Object { item };
    
    -- 返回下一个节点
    getNext() : QueueNode { next };
    
    -- 设置下一个节点
    setNext(n : QueueNode) : QueueNode {
        {
            next <- n;
            self;
        }
    };
};

(*
 * Queue 类
 * 实现了队列的核心功能（FIFO）。内部使用QueueNode构成的链表来存储数据。
 * 队列有front（队首）和rear（队尾）两个指针。
 *)
class Queue inherits IO {
    front : QueueNode;  -- 指向队首节点
    rear : QueueNode;   -- 指向队尾节点
    
    -- 初始化队列
    init() : Queue {
        {
            front <- new QueueNode;  -- 初始化为空节点
            rear <- new QueueNode;   -- 初始化为空节点
            self;
        }
    };
    
    -- isEmpty(): 检查队列是否为空
    isEmpty() : Bool {
        if isvoid front then
            true
        else
            if isvoid front.getItem() then
                true
            else
                false
            fi
        fi
    };
    
    -- enqueue(item: Object): 将一个元素加入队尾
    enqueue(item : Object) : SELF_TYPE {
        {
            let new_node : QueueNode <- (new QueueNode).init(item, new QueueNode) in
            {
                if isEmpty() then
                    {
                        front <- new_node;
                        rear <- new_node;
                    }
                else
                    {
                        rear.setNext(new_node);
                        rear <- new_node;
                    }
                fi;
            };
            self;
        }
    };
    
    -- dequeue(): 移除并返回队首元素
    dequeue() : Object {
        if isEmpty() then
            {
                out_string("Error: dequeue from an empty queue.\n");
                new String;  -- 返回一个新字符串作为错误指示
            }
        else
            let item_to_return : Object <- front.getItem(),
                old_front : QueueNode <- front in
            {
                front <- front.getNext();
                if isvoid front then
                    rear <- new QueueNode  -- 重置rear
                else
                    true
                fi;
                item_to_return;
            }
        fi
    };
    
    -- front(): 返回队首元素，但不移除它
    front() : Object {
        if isEmpty() then
            {
                out_string("Error: front from an empty queue.\n");
                new String;  -- 返回一个新字符串作为错误指示
            }
        else
            front.getItem()
        fi
    };
    
    -- print(): 打印队列内所有元素，从队首到队尾
    print() : SELF_TYPE {
        if isEmpty() then
            out_string("Queue is empty.\n")
        else
            {
                out_string("---- Front of Queue ----\n");
                let current : QueueNode <- front in
                while not isvoid current loop
                    {
                        if not isvoid current.getItem() then  -- 添加空值检查
                            case current.getItem() of
                                s : String => { out_string(s); out_string("\n"); };
                                i : Int => { out_int(i); out_string("\n"); };
                                o : Object => out_string("Object\n");
                            esac
                        else
                            true  -- 跳过空节点
                        fi;
                        current <- current.getNext();
                    }
                pool;
                out_string("---- Rear of Queue ----\n");
            }
        fi
    };
};

(*
 * Main 类
 * 用于测试我们实现的Queue。
 *)
class Main inherits IO {
    main() : Object {
        let my_queue : Queue <- (new Queue).init() in
        {
            out_string("==== Queue Demo ====\n\n");
            
            -- 1. 测试初始状态
            out_string("1. Testing initial state:\n");
            out_string("Is queue empty? ");
            if my_queue.isEmpty() then 
                out_string("Yes\n") 
            else 
                out_string("No\n") 
            fi;
            my_queue.print();
            out_string("\n");
            
            -- 2. 入队操作
            out_string("2. Enqueue operations:\n");
            out_string("Enqueuing 'First', 42, 'Second', 100...\n");
            my_queue.enqueue("First");
            my_queue.enqueue(42);
            my_queue.enqueue("Second");
            my_queue.enqueue(100);
            my_queue.print();
            out_string("\n");
            
            -- 3. 测试front方法
            out_string("3. Testing front() method:\n");
            out_string("Front element: ");
            let front_elem : Object <- my_queue.front() in
                if not isvoid front_elem then
                    case front_elem of
                        s : String => out_string(s);
                        i : Int => out_int(i);
                        o : Object => out_string("Object");
                    esac
                else
                    out_string("Void")
                fi;
            out_string("\n");
            my_queue.print();
            out_string("\n");
            
            -- 4. 测试dequeue方法
            out_string("4. Testing dequeue() method:\n");
            out_string("Dequeuing elements:\n");
            let count : Int <- 0 in
            while count < 2 loop
                {
                    out_string("Dequeued: ");
                    let dequeued_elem : Object <- my_queue.dequeue() in
                        if not isvoid dequeued_elem then
                            case dequeued_elem of
                                s : String => out_string(s);
                                i : Int => out_int(i);
                                o : Object => out_string("Object");
                            esac
                        else
                            out_string("Void")
                        fi;
                    out_string("\n");
                    count <- count + 1;
                }
            pool;
            my_queue.print();
            out_string("\n");
            
            -- 5. 继续出队直到队列为空
            out_string("5. Dequeue until empty:\n");
            while not my_queue.isEmpty() loop
                {
                    out_string("Dequeued: ");
                    let dequeued_elem : Object <- my_queue.dequeue() in
                        if not isvoid dequeued_elem then
                            case dequeued_elem of
                                s : String => out_string(s);
                                i : Int => out_int(i);
                                o : Object => out_string("Object");
                            esac
                        else
                            out_string("Void")
                        fi;
                    out_string("\n");
                }
            pool;
            my_queue.print();
            out_string("\n");
            
            -- 6. 测试空队列操作
            out_string("6. Testing empty queue operations:\n");
            out_string("Calling dequeue() on empty queue: ");
            let result : Object <- my_queue.dequeue() in
                if not isvoid result then
                    case result of
                        s : String => out_string(s);
                        i : Int => out_int(i);
                        o : Object => out_string("Object");
                    esac
                else
                    out_string("Void")
                fi;
            out_string("\n");
            
            out_string("Calling front() on empty queue: ");
            let front_result : Object <- my_queue.front() in
                if not isvoid front_result then
                    case front_result of
                        s : String => out_string(s);
                        i : Int => out_int(i);
                        o : Object => out_string("Object");
                    esac
                else
                    out_string("Void")
                fi;
            out_string("\n");
            
            out_string("\nDemo completed successfully!\n");
        }
    };
};
