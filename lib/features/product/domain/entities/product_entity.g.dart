// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductEntityAdapter extends TypeAdapter<ProductEntity> {
  @override
  final int typeId = 0;

  @override
  ProductEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductEntity(
      id: fields[0] as int?,
      title: fields[1] as String?,
      price: fields[2] as int?,
      discount: fields[3] as int?,
      image: fields[4] as String?,
      status: fields[5] as int?,
      previousPrice: fields[6] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, ProductEntity obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.discount)
      ..writeByte(4)
      ..write(obj.image)
      ..writeByte(5)
      ..write(obj.status)
      ..writeByte(6)
      ..write(obj.previousPrice);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
