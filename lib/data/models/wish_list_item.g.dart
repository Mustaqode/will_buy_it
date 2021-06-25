// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wish_list_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WishListItemAdapter extends TypeAdapter<WishListItem> {
  @override
  final int typeId = 0;

  @override
  WishListItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WishListItem(
      listTitle: fields[0] as String,
      listDescription: fields[1] as String,
      totalListItemCost: fields[2] as double,
      progress: fields[3] as double,
      isWishFullfilled: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, WishListItem obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.listTitle)
      ..writeByte(1)
      ..write(obj.listDescription)
      ..writeByte(2)
      ..write(obj.totalListItemCost)
      ..writeByte(3)
      ..write(obj.progress)
      ..writeByte(4)
      ..write(obj.isWishFullfilled);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WishListItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
