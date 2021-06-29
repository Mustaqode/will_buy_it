// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wish_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WishItemAdapter extends TypeAdapter<WishItem> {
  @override
  final int typeId = 1;

  @override
  WishItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WishItem(
      listTitle: fields[0] as String,
      itemName: fields[1] as String,
      itemDescription: fields[2] as String,
      itemCost: fields[3] as double,
      itemUrl: fields[4] as String?,
      isWishFullfilled: fields[5] as bool,
      currency: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, WishItem obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.listTitle)
      ..writeByte(1)
      ..write(obj.itemName)
      ..writeByte(2)
      ..write(obj.itemDescription)
      ..writeByte(3)
      ..write(obj.itemCost)
      ..writeByte(4)
      ..write(obj.itemUrl)
      ..writeByte(5)
      ..write(obj.isWishFullfilled)
      ..writeByte(6)
      ..write(obj.currency);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WishItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
