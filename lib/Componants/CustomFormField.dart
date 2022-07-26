import 'package:agrosnap/Utils/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomFormField extends StatefulWidget{
  final bool pass, email, done,isEditPlant,cost,dark;
  Function function;
  String value;

  CustomFormField({this.pass=false, this.email=false, this.cost=false,this.value="",
    this.done=false,required this.function,this.isEditPlant=false,this.dark=false});

  @override
  CustomFormFieldState createState() => CustomFormFieldState();
}

class CustomFormFieldState extends State<CustomFormField>{
  bool _obscure = false;
  Icon _icon = Icon(Icons.visibility_off,color: Constants.blueGray,size: 30);

  _getSuffixIcon(){
    if(widget.pass)
      return IconButton(icon: _icon, onPressed: (){
        setState(() {
          _obscure=!_obscure;
          if(!_obscure)
            _icon = Icon(Icons.visibility,color: Constants.primaryColor,size: 30);
          else
            _icon = Icon(Icons.visibility_off,color: Constants.blueGray,size: 30);
        });
      });
  }
  _getPrefixIcon(){
    if(widget.pass)
      return Icon(CupertinoIcons.padlock_solid,color: Constants.blueGray,size: 30);
    else if(widget.email)
    return Icon(Icons.email,color: Constants.blueGray,size: 30);
    else if(widget.isEditPlant){
      if(widget.cost)
        return Icon(Icons.price_change_outlined,color: Constants.blueGray,size: 30);
      else
        return Image.asset("Assets/flower.png",color: Constants.blueGray,width: 24,height: 24);
    }
    else
    return Icon(Icons.storefront_rounded,color: Constants.blueGray,size: 30);
  }

  @override
  void initState() {
    super.initState();
    if(widget.pass)
      _obscure = true;
  }

  getKeyBoard(){
    if(widget.pass)
      return TextInputType.visiblePassword;
    else if(widget.cost)
      return TextInputType.number;
    else
      return TextInputType.text;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: Constants.getScreenHeight(context)*0.01,
      ),
      width: (widget.cost)?Constants.getScreenWidth(context)*0.36:null,
      padding: EdgeInsets.symmetric(horizontal: Constants.getScreenWidth(context)*0.016),
      decoration: BoxDecoration(
        color: (widget.dark)?Constants.darkBlueLight:Constants.blueLight,
        borderRadius: BorderRadius.circular(40.0),
      ),
      child: TextFormField(
        textAlign: TextAlign.center,
        keyboardType: getKeyBoard(),
        autofocus: false,
        decoration: InputDecoration(
          prefixIcon: _getPrefixIcon(),
          suffixIcon: _getSuffixIcon(),
          border: InputBorder.none,
          hintText: widget.value
        ),
        obscureText: _obscure,
        style: TextStyle(
          fontSize: 20.0,
          color: Constants.blueGray,
        ),
        cursorColor: Constants.secondaryColor,
        onSaved: (widget.isEditPlant)?null:(String? input){
          widget.function(input);
        },
        onChanged: (widget.isEditPlant)?(String? input){
          widget.function(input);
        }:null,
        validator: (String? input){
          if(widget.pass) {
            if (!RegExp(r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{8,}$').hasMatch(input!))
              return 'Invalid password';
            else
              return null;
          }
          else if(widget.email) {
            if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(input!))
              return 'Invalid Email';
            return null;
          }
          else {
            if(input!.trim()=='')
              return 'Invalid name';
            return null;
          }
        },
        textInputAction: (widget.done)?TextInputAction.done:TextInputAction.next,
      ),
    );
  }
}