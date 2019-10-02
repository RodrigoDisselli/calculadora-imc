class Pessoa {
  double weight;
  double height;
  int sex;
  double imc = 0;
  String description;
  String result;
  int status;

  Pessoa({this.weight, this.height, this.sex});

  calculateImc(weight, height, sex){

    height = height / 100;
    imc = weight / (height * height);

    print(sex);

    classifyImc(imc);

  }

  classifyImc(imc){
    if (((sex == 2) && (imc < 18.6)) || ((sex == 2) && (imc < 20.7))){
      status = 0;
      result = "Abaixo do peso";
    }else if (((sex == 2) && (imc < 25)) || ((sex == 2) && (imc < 26.4))){
      status = 1;
      result = "Peso ideal";
    }else if (((sex == 1) && (imc < 27.3)) || ((sex == 2) && (imc < 27.8))){
      status = 2;
      result = "Levemente acima do peso";
    }else if (((sex == 1) && (imc < 32.3)) || ((sex == 2) && (imc < 31.1))){
      status = 3;
      result = "Obesidade Grau I";
    }else if (((sex == 1) && (imc > 32.3)) || ((sex == 2) && (imc > 31.1))){
      status = 4;
      result = "Obesidade Grau II";
    }else{
      status = 5;
      result = "Obesidade Grau IIII";
    }
  }

}