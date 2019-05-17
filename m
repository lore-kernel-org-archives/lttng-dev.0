From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH barectf 2/2] Cleanup: bitfields: streamline use
 of underscores
Date: Fri, 17 May 2019 10:35:37 -0400
Message-ID: <20190517143537.13182-2-mathieu.desnoyers__303.006851912357$1558103763$gmane$org@efficios.com>
References: <20190517143537.13182-1-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 4559nb0Nmfz10Lk
 for <lttng-dev@lists.lttng.org>; Fri, 17 May 2019 10:35:46 -0400 (EDT)
In-Reply-To: <20190517143537.13182-1-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: pproulx@efficios.com, jgalar@efficios.com, joraj@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Do not prefix macro arguments with underscores. Use one leading
underscore as prefix for local variables defined within macros.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 barectf/templates.py | 210 +++++++++++++++++++++++++--------------------------
 1 file changed, 105 insertions(+), 105 deletions(-)

diff --git a/barectf/templates.py b/barectf/templates.py
index 6444da4..63aa5c2 100644
--- a/barectf/templates.py
+++ b/barectf/templates.py
@@ -622,10 +622,10 @@ _BITFIELD = '''#ifndef _$PREFIX$BITFIELD_H
 #include <limits.h>
 
 #ifdef __cplusplus
-# define CAST_PTR(_type, _value) \\
-	static_cast<_type>(static_cast<void *>(_value))
+# define CAST_PTR(type, value) \\
+	static_cast<type>(static_cast<void *>(value))
 #else
-# define CAST_PTR(_type, _value)	((void *) (_value))
+# define CAST_PTR(type, value)	((void *) (value))
 #endif
 
 #define $PREFIX$BYTE_ORDER $ENDIAN_DEF$
@@ -698,8 +698,8 @@ _BITFIELD = '''#ifndef _$PREFIX$BITFIELD_H
  * This macro should not be used if `shift` can be greater or equal than
  * the bitwidth of `v`. See `_bt_safe_lshift`.
  */
-#define _$prefix$bt_lshift(_vtype, v, shift)				\\
-	((_vtype) (_$prefix$bt_cast_value_to_unsigned(v) << (shift)))
+#define _$prefix$bt_lshift(vtype, v, shift)				\\
+	((vtype) (_$prefix$bt_cast_value_to_unsigned(v) << (shift)))
 
 /*
  * Generate a mask of type `type` with the `length` least significant bits
@@ -733,11 +733,11 @@ _BITFIELD = '''#ifndef _$PREFIX$BITFIELD_H
  * the bitwidth of `v`. See `_bt_safe_rshift`.
  */
 #if ((-1 >> 1) == -1)
-#define _$prefix$bt_rshift(_vtype, v, shift)	((v) >> (shift))
+#define _$prefix$bt_rshift(vtype, v, shift)	((v) >> (shift))
 #else
-#define _$prefix$bt_rshift(_vtype, v, shift)				\\
-	((_vtype) ((_$prefix$bt_cast_value_to_unsigned(v) >> (shift)) |	\\
-		((v) < 0 ? _$prefix$bt_make_mask_complement(_vtype,	\\
+#define _$prefix$bt_rshift(vtype, v, shift)				\\
+	((vtype) ((_$prefix$bt_cast_value_to_unsigned(v) >> (shift)) |	\\
+		((v) < 0 ? _$prefix$bt_make_mask_complement(vtype,	\\
 			sizeof(v) * CHAR_BIT - (shift)) : 0)))
 #endif
 
@@ -793,122 +793,122 @@ do {									\\
  * Also, consecutive bitfields are placed from higher to lower bits.
  */
 
-#define _$prefix$bt_bitfield_write_le(_ptr, type, _start, _length, _vtype, _v) \\
+#define _$prefix$bt_bitfield_write_le(ptr, type, start, length, vtype, v) \\
 do {									\\
-	_vtype __v = (_v);						\\
-	type *__ptr = CAST_PTR(type *, _ptr);				\\
-	unsigned long __start = (_start), __length = (_length);		\\
-	type mask, cmask;						\\
-	unsigned long ts = sizeof(type) * CHAR_BIT; /* type size */	\\
-	unsigned long start_unit, end_unit, this_unit;			\\
-	unsigned long end, cshift; /* cshift is "complement shift" */	\\
+	vtype _v = (v);							\\
+	type *_ptr = CAST_PTR(type *, ptr);				\\
+	unsigned long _start = (start), _length = (length);		\\
+	type _mask, _cmask;						\\
+	unsigned long _ts = sizeof(type) * CHAR_BIT; /* type size */	\\
+	unsigned long _start_unit, _end_unit, _this_unit;		\\
+	unsigned long _end, _cshift; /* _cshift is "complement shift" */ \\
 									\\
-	if (!__length)							\\
+	if (!_length)							\\
 		break;							\\
 									\\
-	end = __start + __length;					\\
-	start_unit = __start / ts;					\\
-	end_unit = (end + (ts - 1)) / ts;				\\
+	_end = _start + _length;					\\
+	_start_unit = _start / _ts;					\\
+	_end_unit = (_end + (_ts - 1)) / _ts;				\\
 									\\
 	/* Trim v high bits */						\\
-	if (__length < sizeof(__v) * CHAR_BIT)				\\
-		__v &= _$prefix$bt_make_mask(_vtype, __length);		\\
+	if (_length < sizeof(_v) * CHAR_BIT)				\\
+		_v &= _$prefix$bt_make_mask(vtype, _length);		\\
 									\\
 	/* We can now append v with a simple "or", shift it piece-wise */ \\
-	this_unit = start_unit;						\\
-	if (start_unit == end_unit - 1) {				\\
-		mask = _$prefix$bt_make_mask(type, __start % ts);	\\
-		if (end % ts)						\\
-			mask |= _$prefix$bt_make_mask_complement(type, end % ts); \\
-		cmask = _$prefix$bt_lshift(type, (type) (__v), __start % ts); \\
-		cmask &= ~mask;						\\
-		__ptr[this_unit] &= mask;				\\
-		__ptr[this_unit] |= cmask;				\\
+	_this_unit = _start_unit;					\\
+	if (_start_unit == _end_unit - 1) {				\\
+		_mask = _$prefix$bt_make_mask(type, _start % _ts);	\\
+		if (_end % _ts)						\\
+			_mask |= _$prefix$bt_make_mask_complement(type, _end % _ts); \\
+		_cmask = _$prefix$bt_lshift(type, (type) (_v), _start % _ts); \\
+		_cmask &= ~_mask;					\\
+		_ptr[_this_unit] &= _mask;				\\
+		_ptr[_this_unit] |= _cmask;				\\
 		break;							\\
 	}								\\
-	if (__start % ts) {						\\
-		cshift = __start % ts;					\\
-		mask = _$prefix$bt_make_mask(type, cshift);		\\
-		cmask = _$prefix$bt_lshift(type, (type) (__v), cshift);	\\
-		cmask &= ~mask;						\\
-		__ptr[this_unit] &= mask;				\\
-		__ptr[this_unit] |= cmask;				\\
-		_$prefix$bt_safe_rshift(_vtype, __v, ts - cshift); \\
-		__start += ts - cshift;					\\
-		this_unit++;						\\
+	if (_start % _ts) {						\\
+		_cshift = _start % _ts;					\\
+		_mask = _$prefix$bt_make_mask(type, _cshift);		\\
+		_cmask = _$prefix$bt_lshift(type, (type) (_v), _cshift); \\
+		_cmask &= ~_mask;					\\
+		_ptr[_this_unit] &= _mask;				\\
+		_ptr[_this_unit] |= _cmask;				\\
+		_$prefix$bt_safe_rshift(vtype, _v, _ts - _cshift);	\\
+		_start += _ts - _cshift;				\\
+		_this_unit++;						\\
 	}								\\
-	for (; this_unit < end_unit - 1; this_unit++) {			\\
-		__ptr[this_unit] = (type) __v;				\\
-		_$prefix$bt_safe_rshift(_vtype, __v, ts); 		\\
-		__start += ts;						\\
+	for (; _this_unit < _end_unit - 1; _this_unit++) {		\\
+		_ptr[_this_unit] = (type) _v;				\\
+		_$prefix$bt_safe_rshift(vtype, _v, _ts); 		\\
+		_start += _ts;						\\
 	}								\\
-	if (end % ts) {							\\
-		mask = _$prefix$bt_make_mask_complement(type, end % ts); \\
-		cmask = (type) __v;					\\
-		cmask &= ~mask;						\\
-		__ptr[this_unit] &= mask;				\\
-		__ptr[this_unit] |= cmask;				\\
+	if (_end % _ts) {						\\
+		_mask = _$prefix$bt_make_mask_complement(type, _end % _ts); \\
+		_cmask = (type) _v;					\\
+		_cmask &= ~_mask;					\\
+		_ptr[_this_unit] &= _mask;				\\
+		_ptr[_this_unit] |= _cmask;				\\
 	} else								\\
-		__ptr[this_unit] = (type) __v;				\\
+		_ptr[_this_unit] = (type) _v;				\\
 } while (0)
 
-#define _$prefix$bt_bitfield_write_be(_ptr, type, _start, _length, _vtype, _v) \\
+#define _$prefix$bt_bitfield_write_be(ptr, type, start, length, vtype, v) \\
 do {									\\
-	_vtype __v = (_v);						\\
-	type *__ptr = CAST_PTR(type *, _ptr);				\\
-	unsigned long __start = (_start), __length = (_length);		\\
-	type mask, cmask;						\\
-	unsigned long ts = sizeof(type) * CHAR_BIT; /* type size */	\\
-	unsigned long start_unit, end_unit, this_unit;			\\
-	unsigned long end, cshift; /* cshift is "complement shift" */	\\
+	vtype _v = (v);							\\
+	type *_ptr = CAST_PTR(type *, ptr);				\\
+	unsigned long _start = (start), _length = (length);		\\
+	type _mask, _cmask;						\\
+	unsigned long _ts = sizeof(type) * CHAR_BIT; /* type size */	\\
+	unsigned long _start_unit, _end_unit, _this_unit;		\\
+	unsigned long _end, _cshift; /* _cshift is "complement shift" */ \\
 									\\
-	if (!__length)							\\
+	if (!_length)							\\
 		break;							\\
 									\\
-	end = __start + __length;					\\
-	start_unit = __start / ts;					\\
-	end_unit = (end + (ts - 1)) / ts;				\\
+	_end = _start + _length;					\\
+	_start_unit = _start / _ts;					\\
+	_end_unit = (_end + (_ts - 1)) / _ts;				\\
 									\\
 	/* Trim v high bits */						\\
-	if (__length < sizeof(__v) * CHAR_BIT)				\\
-		__v &= _$prefix$bt_make_mask(_vtype, __length);		\\
+	if (_length < sizeof(_v) * CHAR_BIT)				\\
+		_v &= _$prefix$bt_make_mask(vtype, _length);		\\
 									\\
 	/* We can now append v with a simple "or", shift it piece-wise */ \\
-	this_unit = end_unit - 1;					\\
-	if (start_unit == end_unit - 1) {				\\
-		mask = _$prefix$bt_make_mask(type, (ts - (end % ts)) % ts); \\
-		if (__start % ts)					\\
-			mask |= _$prefix$bt_make_mask_complement(type, ts - (__start % ts)); \\
-		cmask = _$prefix$bt_lshift(type, (type) (__v), (ts - (end % ts)) % ts); \\
-		cmask &= ~mask;						\\
-		__ptr[this_unit] &= mask;				\\
-		__ptr[this_unit] |= cmask;				\\
+	_this_unit = _end_unit - 1;					\\
+	if (_start_unit == _end_unit - 1) {				\\
+		_mask = _$prefix$bt_make_mask(type, (_ts - (_end % _ts)) % _ts); \\
+		if (_start % _ts)					\\
+			_mask |= _$prefix$bt_make_mask_complement(type, _ts - (_start % _ts)); \\
+		_cmask = _$prefix$bt_lshift(type, (type) (_v), (_ts - (_end % _ts)) % _ts); \\
+		_cmask &= ~_mask;					\\
+		_ptr[_this_unit] &= _mask;				\\
+		_ptr[_this_unit] |= _cmask;				\\
 		break;							\\
 	}								\\
-	if (end % ts) {							\\
-		cshift = end % ts;					\\
-		mask = _$prefix$bt_make_mask(type, ts - cshift);	\\
-		cmask = _$prefix$bt_lshift(type, (type) (__v), ts - cshift); \\
-		cmask &= ~mask;						\\
-		__ptr[this_unit] &= mask;				\\
-		__ptr[this_unit] |= cmask;				\\
-		_$prefix$bt_safe_rshift(_vtype, __v, cshift); \\
-		end -= cshift;						\\
-		this_unit--;						\\
+	if (_end % _ts) {						\\
+		_cshift = _end % _ts;					\\
+		_mask = _$prefix$bt_make_mask(type, _ts - _cshift);	\\
+		_cmask = _$prefix$bt_lshift(type, (type) (_v), _ts - _cshift); \\
+		_cmask &= ~_mask;					\\
+		_ptr[_this_unit] &= _mask;				\\
+		_ptr[_this_unit] |= _cmask;				\\
+		_$prefix$bt_safe_rshift(vtype, _v, _cshift);		\\
+		_end -= _cshift;					\\
+		_this_unit--;						\\
 	}								\\
-	for (; (long) this_unit >= (long) start_unit + 1; this_unit--) { \\
-		__ptr[this_unit] = (type) __v;				\\
-		_$prefix$bt_safe_rshift(_vtype, __v, ts); \\
-		end -= ts;						\\
+	for (; (long) _this_unit >= (long) _start_unit + 1; _this_unit--) { \\
+		_ptr[_this_unit] = (type) _v;				\\
+		_$prefix$bt_safe_rshift(vtype, _v, _ts); 		\\
+		_end -= _ts;						\\
 	}								\\
-	if (__start % ts) {						\\
-		mask = _$prefix$bt_make_mask_complement(type, ts - (__start % ts)); \\
-		cmask = (type) __v;					\\
-		cmask &= ~mask;						\\
-		__ptr[this_unit] &= mask;				\\
-		__ptr[this_unit] |= cmask;				\\
+	if (_start % _ts) {						\\
+		_mask = _$prefix$bt_make_mask_complement(type, _ts - (_start % _ts)); \\
+		_cmask = (type) _v;					\\
+		_cmask &= ~_mask;					\\
+		_ptr[_this_unit] &= _mask;				\\
+		_ptr[_this_unit] |= _cmask;				\\
 	} else								\\
-		__ptr[this_unit] = (type) __v;				\\
+		_ptr[_this_unit] = (type) _v;				\\
 } while (0)
 
 /*
@@ -918,19 +918,19 @@ do {									\\
 
 #if ($PREFIX$BYTE_ORDER == LITTLE_ENDIAN)
 
-#define $prefix$bt_bitfield_write_le(ptr, type, _start, _length, _vtype, _v) \\
-	_$prefix$bt_bitfield_write_le(ptr, type, _start, _length, _vtype, _v)
+#define $prefix$bt_bitfield_write_le(ptr, type, start, length, vtype, v) \\
+	_$prefix$bt_bitfield_write_le(ptr, type, start, length, vtype, v)
 
-#define $prefix$bt_bitfield_write_be(ptr, type, _start, _length, _vtype, _v) \\
-	_$prefix$bt_bitfield_write_be(ptr, unsigned char, _start, _length, _vtype, _v)
+#define $prefix$bt_bitfield_write_be(ptr, type, start, length, vtype, v) \\
+	_$prefix$bt_bitfield_write_be(ptr, unsigned char, start, length, vtype, v)
 
 #elif ($PREFIX$BYTE_ORDER == BIG_ENDIAN)
 
-#define $prefix$bt_bitfield_write_le(ptr, type, _start, _length, _vtype, _v) \\
-	_$prefix$bt_bitfield_write_le(ptr, unsigned char, _start, _length, _vtype, _v)
+#define $prefix$bt_bitfield_write_le(ptr, type, start, length, vtype, v) \\
+	_$prefix$bt_bitfield_write_le(ptr, unsigned char, start, length, vtype, v)
 
-#define $prefix$bt_bitfield_write_be(ptr, type, _start, _length, _vtype, _v) \\
-	_$prefix$bt_bitfield_write_be(ptr, type, _start, _length, _vtype, _v)
+#define $prefix$bt_bitfield_write_be(ptr, type, start, length, vtype, v) \\
+	_$prefix$bt_bitfield_write_be(ptr, type, start, length, vtype, v)
 
 #else /* ($PREFIX$BYTE_ORDER == PDP_ENDIAN) */
 
-- 
2.11.0
