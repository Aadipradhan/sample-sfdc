class dog extends Animal{
    constructor(name){
        super(name);
        this.name = name
    }

    makeSound(){
        console.log(`${this.name} is barking.`);
    }
}