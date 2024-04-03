// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductModelAdapter extends TypeAdapter<ProductModel> {
  @override
  final int typeId = 3;

  @override
  ProductModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductModel(
      id: fields[0] as String,
      name: fields[1] as String,
      description: fields[2] as String,
      imageUrl: fields[3] as String,
      price: fields[4] as double,
      rate: fields[5] as double,
      nutritions: fields[6] as List<String>,
    );
  }

  @override
  void write(BinaryWriter writer, ProductModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj._id)
      ..writeByte(1)
      ..write(obj._name)
      ..writeByte(2)
      ..write(obj._description)
      ..writeByte(3)
      ..write(obj._imageUrl)
      ..writeByte(4)
      ..write(obj._price)
      ..writeByte(5)
      ..write(obj._rate)
      ..writeByte(6)
      ..write(obj._nutritions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
