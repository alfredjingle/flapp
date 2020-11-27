class KeyValue<K, V> {
  K key;
  V value;

  KeyValue([this.key, this.value]);

  bool operator ==(other) {
    return (other is KeyValue<K, V> &&
        other.key == key &&
        other.value == value);
  }

  int get hashCode => key.hashCode ^ value.hashCode;
}
