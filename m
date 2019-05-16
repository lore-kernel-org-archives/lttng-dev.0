From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH babeltrace 3/4] Cleanup: bitfields: streamline
 use of underscores
Date: Thu, 16 May 2019 16:58:47 -0400
Message-ID: <20190516205848.20409-3-mathieu.desnoyers__4657.35900668136$1558040425$gmane$org@efficios.com>
References: <20190516205848.20409-1-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 454kL82x4rz10DQ
 for <lttng-dev@lists.lttng.org>; Thu, 16 May 2019 16:58:56 -0400 (EDT)
In-Reply-To: <20190516205848.20409-1-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: jgalar@efficios.com, simon.marchi@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Do not prefix macro arguments with underscores. Use one leading
underscore as prefix for local variables defined within macros.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Change-Id: Ie1c2f7f59f605ac62d483aba67b3f70cef27bf21
---
 include/babeltrace/bitfield-internal.h | 436 ++++++++++++++++-----------------
 1 file changed, 218 insertions(+), 218 deletions(-)

diff --git a/include/babeltrace/bitfield-internal.h b/include/babeltrace/bitfield-internal.h
index bb0283a3..6969179c 100644
--- a/include/babeltrace/bitfield-internal.h
+++ b/include/babeltrace/bitfield-internal.h
@@ -218,122 +218,122 @@ do {									\
  * Also, consecutive bitfields are placed from higher to lower bits.
  */
 
-#define _bt_bitfield_write_le(_ptr, type, _start, _length, _v)		\
+#define _bt_bitfield_write_le(ptr, type, start, length, v)		\
 do {									\
-	__typeof__(_v) __v = (_v);					\
-	type *__ptr = (void *) (_ptr);					\
-	unsigned long __start = (_start), __length = (_length);		\
-	type mask, cmask;						\
-	unsigned long ts = sizeof(type) * CHAR_BIT; /* type size */	\
-	unsigned long start_unit, end_unit, this_unit;			\
-	unsigned long end, cshift; /* cshift is "complement shift" */	\
+	__typeof__(v) _v = (v);					\
+	type *_ptr = (void *) (ptr);					\
+	unsigned long _start = (start), _length = (length);		\
+	type _mask, _cmask;						\
+	unsigned long _ts = sizeof(type) * CHAR_BIT; /* type size */	\
+	unsigned long _start_unit, _end_unit, _this_unit;		\
+	unsigned long _end, _cshift; /* _cshift is "complement shift" */ \
 									\
-	if (!__length)							\
+	if (!_length)							\
 		break;							\
 									\
-	end = __start + __length;					\
-	start_unit = __start / ts;					\
-	end_unit = (end + (ts - 1)) / ts;				\
+	_end = _start + _length;					\
+	_start_unit = _start / _ts;					\
+	_end_unit = (_end + (_ts - 1)) / _ts;				\
 									\
 	/* Trim v high bits */						\
-	if (__length < sizeof(__v) * CHAR_BIT)				\
-		__v &= _bt_make_mask(__typeof__(__v), __length);	\
+	if (_length < sizeof(_v) * CHAR_BIT)				\
+		_v &= _bt_make_mask(__typeof__(_v), _length);		\
 									\
 	/* We can now append v with a simple "or", shift it piece-wise */ \
-	this_unit = start_unit;						\
-	if (start_unit == end_unit - 1) {				\
-		mask = _bt_make_mask(type, __start % ts);		\
-		if (end % ts)						\
-			mask |= _bt_make_mask_complement(type, end % ts); \
-		cmask = _bt_lshift((type) (__v), __start % ts);		\
-		cmask &= ~mask;						\
-		__ptr[this_unit] &= mask;				\
-		__ptr[this_unit] |= cmask;				\
+	_this_unit = _start_unit;					\
+	if (_start_unit == _end_unit - 1) {				\
+		_mask = _bt_make_mask(type, _start % _ts);		\
+		if (_end % _ts)						\
+			_mask |= _bt_make_mask_complement(type, _end % _ts); \
+		_cmask = _bt_lshift((type) (_v), _start % _ts);		\
+		_cmask &= ~_mask;					\
+		_ptr[_this_unit] &= _mask;				\
+		_ptr[_this_unit] |= _cmask;				\
 		break;							\
 	}								\
-	if (__start % ts) {						\
-		cshift = __start % ts;					\
-		mask = _bt_make_mask(type, cshift);			\
-		cmask = _bt_lshift((type) (__v), cshift);		\
-		cmask &= ~mask;						\
-		__ptr[this_unit] &= mask;				\
-		__ptr[this_unit] |= cmask;				\
-		_bt_safe_rshift(__v, ts - cshift);			\
-		__start += ts - cshift;					\
-		this_unit++;						\
+	if (_start % _ts) {						\
+		_cshift = _start % _ts;					\
+		_mask = _bt_make_mask(type, _cshift);			\
+		_cmask = _bt_lshift((type) (_v), _cshift);		\
+		_cmask &= ~_mask;					\
+		_ptr[_this_unit] &= _mask;				\
+		_ptr[_this_unit] |= _cmask;				\
+		_bt_safe_rshift(_v, _ts - _cshift);			\
+		_start += _ts - _cshift;				\
+		_this_unit++;						\
 	}								\
-	for (; this_unit < end_unit - 1; this_unit++) {			\
-		__ptr[this_unit] = (type) __v;				\
-		_bt_safe_rshift(__v, ts);				\
-		__start += ts;						\
+	for (; _this_unit < _end_unit - 1; _this_unit++) {		\
+		_ptr[_this_unit] = (type) _v;				\
+		_bt_safe_rshift(_v, _ts);				\
+		_start += _ts;						\
 	}								\
-	if (end % ts) {							\
-		mask = _bt_make_mask_complement(type, end % ts);	\
-		cmask = (type) __v;					\
-		cmask &= ~mask;						\
-		__ptr[this_unit] &= mask;				\
-		__ptr[this_unit] |= cmask;				\
+	if (_end % _ts) {						\
+		_mask = _bt_make_mask_complement(type, _end % _ts);	\
+		_cmask = (type) _v;					\
+		_cmask &= ~_mask;					\
+		_ptr[_this_unit] &= _mask;				\
+		_ptr[_this_unit] |= _cmask;				\
 	} else								\
-		__ptr[this_unit] = (type) __v;				\
+		_ptr[_this_unit] = (type) _v;				\
 } while (0)
 
-#define _bt_bitfield_write_be(_ptr, type, _start, _length, _v)		\
+#define _bt_bitfield_write_be(ptr, type, start, length, v)		\
 do {									\
-	__typeof__(_v) __v = (_v);					\
-	type *__ptr = (void *) (_ptr);					\
-	unsigned long __start = (_start), __length = (_length);		\
-	type mask, cmask;						\
-	unsigned long ts = sizeof(type) * CHAR_BIT; /* type size */	\
-	unsigned long start_unit, end_unit, this_unit;			\
-	unsigned long end, cshift; /* cshift is "complement shift" */	\
+	__typeof__(v) _v = (v);						\
+	type *_ptr = (void *) (ptr);					\
+	unsigned long _start = (start), _length = (length);		\
+	type _mask, _cmask;						\
+	unsigned long _ts = sizeof(type) * CHAR_BIT; /* type size */	\
+	unsigned long _start_unit, _end_unit, _this_unit;		\
+	unsigned long _end, _cshift; /* _cshift is "complement shift" */ \
 									\
-	if (!__length)							\
+	if (!_length)							\
 		break;							\
 									\
-	end = __start + __length;					\
-	start_unit = __start / ts;					\
-	end_unit = (end + (ts - 1)) / ts;				\
+	_end = _start + _length;					\
+	_start_unit = _start / _ts;					\
+	_end_unit = (_end + (_ts - 1)) / _ts;				\
 									\
 	/* Trim v high bits */						\
-	if (__length < sizeof(__v) * CHAR_BIT)				\
-		__v &= _bt_make_mask(__typeof__(__v), __length);	\
+	if (_length < sizeof(_v) * CHAR_BIT)				\
+		_v &= _bt_make_mask(__typeof__(_v), _length);		\
 									\
 	/* We can now append v with a simple "or", shift it piece-wise */ \
-	this_unit = end_unit - 1;					\
-	if (start_unit == end_unit - 1) {				\
-		mask = _bt_make_mask(type, (ts - (end % ts)) % ts);	\
-		if (__start % ts)					\
-			mask |= _bt_make_mask_complement(type, ts - (__start % ts)); \
-		cmask = _bt_lshift((type) (__v), (ts - (end % ts)) % ts); \
-		cmask &= ~mask;						\
-		__ptr[this_unit] &= mask;				\
-		__ptr[this_unit] |= cmask;				\
+	_this_unit = _end_unit - 1;					\
+	if (_start_unit == _end_unit - 1) {				\
+		_mask = _bt_make_mask(type, (_ts - (_end % _ts)) % _ts); \
+		if (_start % _ts)					\
+			_mask |= _bt_make_mask_complement(type, _ts - (_start % _ts)); \
+		_cmask = _bt_lshift((type) (_v), (_ts - (_end % _ts)) % _ts); \
+		_cmask &= ~_mask;					\
+		_ptr[_this_unit] &= _mask;				\
+		_ptr[_this_unit] |= _cmask;				\
 		break;							\
 	}								\
-	if (end % ts) {							\
-		cshift = end % ts;					\
-		mask = _bt_make_mask(type, ts - cshift);		\
-		cmask = _bt_lshift((type) (__v), ts - cshift);		\
-		cmask &= ~mask;						\
-		__ptr[this_unit] &= mask;				\
-		__ptr[this_unit] |= cmask;				\
-		_bt_safe_rshift(__v, cshift);				\
-		end -= cshift;						\
-		this_unit--;						\
+	if (_end % _ts) {						\
+		_cshift = _end % _ts;					\
+		_mask = _bt_make_mask(type, _ts - _cshift);		\
+		_cmask = _bt_lshift((type) (_v), _ts - _cshift);	\
+		_cmask &= ~_mask;					\
+		_ptr[_this_unit] &= _mask;				\
+		_ptr[_this_unit] |= _cmask;				\
+		_bt_safe_rshift(_v, _cshift);				\
+		_end -= _cshift;					\
+		_this_unit--;						\
 	}								\
-	for (; (long) this_unit >= (long) start_unit + 1; this_unit--) { \
-		__ptr[this_unit] = (type) __v;				\
-		_bt_safe_rshift(__v, ts);				\
-		end -= ts;						\
+	for (; (long) _this_unit >= (long) _start_unit + 1; _this_unit--) { \
+		_ptr[_this_unit] = (type) _v;				\
+		_bt_safe_rshift(_v, _ts);				\
+		_end -= _ts;						\
 	}								\
-	if (__start % ts) {						\
-		mask = _bt_make_mask_complement(type, ts - (__start % ts)); \
-		cmask = (type) __v;					\
-		cmask &= ~mask;						\
-		__ptr[this_unit] &= mask;				\
-		__ptr[this_unit] |= cmask;				\
+	if (_start % _ts) {						\
+		_mask = _bt_make_mask_complement(type, _ts - (_start % _ts)); \
+		_cmask = (type) _v;					\
+		_cmask &= ~_mask;					\
+		_ptr[_this_unit] &= _mask;				\
+		_ptr[_this_unit] |= _cmask;				\
 	} else								\
-		__ptr[this_unit] = (type) __v;				\
+		_ptr[_this_unit] = (type) _v;				\
 } while (0)
 
 /*
@@ -344,25 +344,25 @@ do {									\
 
 #if (BYTE_ORDER == LITTLE_ENDIAN)
 
-#define bt_bitfield_write(ptr, type, _start, _length, _v)		\
-	_bt_bitfield_write_le(ptr, type, _start, _length, _v)
+#define bt_bitfield_write(ptr, type, start, length, v)			\
+	_bt_bitfield_write_le(ptr, type, start, length, v)
 
-#define bt_bitfield_write_le(ptr, type, _start, _length, _v)		\
-	_bt_bitfield_write_le(ptr, type, _start, _length, _v)
+#define bt_bitfield_write_le(ptr, type, start, length, v)		\
+	_bt_bitfield_write_le(ptr, type, start, length, v)
 
-#define bt_bitfield_write_be(ptr, type, _start, _length, _v)		\
-	_bt_bitfield_write_be(ptr, unsigned char, _start, _length, _v)
+#define bt_bitfield_write_be(ptr, type, start, length, v)		\
+	_bt_bitfield_write_be(ptr, unsigned char, start, length, v)
 
 #elif (BYTE_ORDER == BIG_ENDIAN)
 
-#define bt_bitfield_write(ptr, type, _start, _length, _v)		\
-	_bt_bitfield_write_be(ptr, type, _start, _length, _v)
+#define bt_bitfield_write(ptr, type, start, length, v)			\
+	_bt_bitfield_write_be(ptr, type, start, length, v)
 
-#define bt_bitfield_write_le(ptr, type, _start, _length, _v)		\
-	_bt_bitfield_write_le(ptr, unsigned char, _start, _length, _v)
+#define bt_bitfield_write_le(ptr, type, start, length, v)		\
+	_bt_bitfield_write_le(ptr, unsigned char, start, length, v)
 
-#define bt_bitfield_write_be(ptr, type, _start, _length, _v)		\
-	_bt_bitfield_write_be(ptr, type, _start, _length, _v)
+#define bt_bitfield_write_be(ptr, type, start, length, v)		\
+	_bt_bitfield_write_be(ptr, type, start, length, v)
 
 #else /* (BYTE_ORDER == PDP_ENDIAN) */
 
@@ -370,148 +370,148 @@ do {									\
 
 #endif
 
-#define _bt_bitfield_read_le(_ptr, type, _start, _length, _vptr)	\
+#define _bt_bitfield_read_le(ptr, type, start, length, vptr)		\
 do {									\
-	__typeof__(*(_vptr)) *__vptr = (_vptr);				\
-	__typeof__(*__vptr) __v;					\
-	type *__ptr = (void *) (_ptr);					\
-	unsigned long __start = (_start), __length = (_length);		\
-	type mask, cmask;						\
-	unsigned long ts = sizeof(type) * CHAR_BIT; /* type size */	\
-	unsigned long start_unit, end_unit, this_unit;			\
-	unsigned long end, cshift; /* cshift is "complement shift" */	\
-	bool is_signed_type;						\
+	__typeof__(*(vptr)) *_vptr = (vptr);				\
+	__typeof__(*_vptr) _v;						\
+	type *_ptr = (void *) (ptr);					\
+	unsigned long _start = (start), _length = (length);		\
+	type _mask, _cmask;						\
+	unsigned long _ts = sizeof(type) * CHAR_BIT; /* type size */	\
+	unsigned long _start_unit, _end_unit, _this_unit;		\
+	unsigned long _end, _cshift; /* _cshift is "complement shift" */ \
+	bool _is_signed_type;						\
 									\
-	if (!__length) {						\
-		*__vptr = 0;						\
+	if (!_length) {							\
+		*_vptr = 0;						\
 		break;							\
 	}								\
 									\
-	end = __start + __length;					\
-	start_unit = __start / ts;					\
-	end_unit = (end + (ts - 1)) / ts;				\
+	_end = _start + _length;					\
+	_start_unit = _start / _ts;					\
+	_end_unit = (_end + (_ts - 1)) / _ts;				\
 									\
-	this_unit = end_unit - 1;					\
+	_this_unit = _end_unit - 1;					\
 	_BT_DIAG_PUSH							\
 	_BT_DIAG_IGNORE_TYPE_LIMITS					\
-	is_signed_type = _bt_is_signed_type(__typeof__(__v));		\
+	_is_signed_type = _bt_is_signed_type(__typeof__(_v));		\
 	_BT_DIAG_POP							\
-	if (is_signed_type						\
-	    && (__ptr[this_unit] & _bt_lshift((type) 1, (end % ts ? end % ts : ts) - 1))) \
-		__v = ~(__typeof__(__v)) 0;				\
+	if (_is_signed_type						\
+	    && (_ptr[_this_unit] & _bt_lshift((type) 1, (_end % _ts ? _end % _ts : _ts) - 1))) \
+		_v = ~(__typeof__(_v)) 0;				\
 	else								\
-		__v = 0;						\
-	if (start_unit == end_unit - 1) {				\
-		cmask = __ptr[this_unit];				\
-		cmask = _bt_rshift(cmask, __start % ts);		\
-		if ((end - __start) % ts) {				\
-			mask = _bt_make_mask(type, end - __start);	\
-			cmask &= mask;					\
+		_v = 0;							\
+	if (_start_unit == _end_unit - 1) {				\
+		_cmask = _ptr[_this_unit];				\
+		_cmask = _bt_rshift(_cmask, _start % _ts);		\
+		if ((_end - _start) % _ts) {				\
+			_mask = _bt_make_mask(type, _end - _start);	\
+			_cmask &= _mask;				\
 		}							\
-		_bt_safe_lshift(__v, end - __start);			\
-		__v |= _bt_cast_value_to_unsigned_type(__typeof__(__v), cmask); \
-		*__vptr = __v;						\
+		_bt_safe_lshift(_v, _end - _start);			\
+		_v |= _bt_cast_value_to_unsigned_type(__typeof__(_v), _cmask); \
+		*_vptr = _v;						\
 		break;							\
 	}								\
-	if (end % ts) {							\
-		cshift = end % ts;					\
-		mask = _bt_make_mask(type, cshift);			\
-		cmask = __ptr[this_unit];				\
-		cmask &= mask;						\
-		_bt_safe_lshift(__v, cshift);				\
-		__v |= _bt_cast_value_to_unsigned_type(__typeof__(__v), cmask); \
-		end -= cshift;						\
-		this_unit--;						\
+	if (_end % _ts) {						\
+		_cshift = _end % _ts;					\
+		_mask = _bt_make_mask(type, _cshift);			\
+		_cmask = _ptr[_this_unit];				\
+		_cmask &= _mask;					\
+		_bt_safe_lshift(_v, _cshift);				\
+		_v |= _bt_cast_value_to_unsigned_type(__typeof__(_v), _cmask); \
+		_end -= _cshift;					\
+		_this_unit--;						\
 	}								\
-	for (; (long) this_unit >= (long) start_unit + 1; this_unit--) { \
-		_bt_safe_lshift(__v, ts);				\
-		__v |= _bt_cast_value_to_unsigned_type(__typeof__(__v), __ptr[this_unit]); \
-		end -= ts;						\
+	for (; (long) _this_unit >= (long) _start_unit + 1; _this_unit--) { \
+		_bt_safe_lshift(_v, _ts);				\
+		_v |= _bt_cast_value_to_unsigned_type(__typeof__(_v), _ptr[_this_unit]); \
+		_end -= _ts;						\
 	}								\
-	if (__start % ts) {						\
-		mask = _bt_make_mask(type, ts - (__start % ts));	\
-		cmask = __ptr[this_unit];				\
-		cmask = _bt_rshift(cmask, __start % ts);		\
-		cmask &= mask;						\
-		_bt_safe_lshift(__v, ts - (__start % ts));		\
-		__v |= _bt_cast_value_to_unsigned_type(__typeof__(__v), cmask); \
+	if (_start % _ts) {						\
+		_mask = _bt_make_mask(type, _ts - (_start % _ts));	\
+		_cmask = _ptr[_this_unit];				\
+		_cmask = _bt_rshift(_cmask, _start % _ts);		\
+		_cmask &= _mask;					\
+		_bt_safe_lshift(_v, _ts - (_start % _ts));		\
+		_v |= _bt_cast_value_to_unsigned_type(__typeof__(_v), _cmask); \
 	} else {							\
-		_bt_safe_lshift(__v, ts);				\
-		__v |= _bt_cast_value_to_unsigned_type(__typeof__(__v), __ptr[this_unit]); \
+		_bt_safe_lshift(_v, _ts);				\
+		_v |= _bt_cast_value_to_unsigned_type(__typeof__(_v), _ptr[_this_unit]); \
 	}								\
-	*__vptr = __v;							\
+	*_vptr = _v;							\
 } while (0)
 
-#define _bt_bitfield_read_be(_ptr, type, _start, _length, _vptr)	\
+#define _bt_bitfield_read_be(ptr, type, start, length, vptr)		\
 do {									\
-	__typeof__(*(_vptr)) *__vptr = (_vptr);				\
-	__typeof__(*__vptr) __v;					\
-	type *__ptr = (void *) (_ptr);					\
-	unsigned long __start = (_start), __length = (_length);		\
-	type mask, cmask;						\
-	unsigned long ts = sizeof(type) * CHAR_BIT; /* type size */	\
-	unsigned long start_unit, end_unit, this_unit;			\
-	unsigned long end, cshift; /* cshift is "complement shift" */	\
-	bool is_signed_type;						\
+	__typeof__(*(vptr)) *_vptr = (vptr);				\
+	__typeof__(*_vptr) _v;						\
+	type *_ptr = (void *) (ptr);					\
+	unsigned long _start = (start), _length = (length);		\
+	type _mask, _cmask;						\
+	unsigned long _ts = sizeof(type) * CHAR_BIT; /* type size */	\
+	unsigned long _start_unit, _end_unit, _this_unit;		\
+	unsigned long _end, _cshift; /* _cshift is "complement shift" */ \
+	bool _is_signed_type;						\
 									\
-	if (!__length) {						\
-		*__vptr = 0;						\
+	if (!_length) {							\
+		*_vptr = 0;						\
 		break;							\
 	}								\
 									\
-	end = __start + __length;					\
-	start_unit = __start / ts;					\
-	end_unit = (end + (ts - 1)) / ts;				\
+	_end = _start + _length;					\
+	_start_unit = _start / _ts;					\
+	_end_unit = (_end + (_ts - 1)) / _ts;				\
 									\
-	this_unit = start_unit;						\
+	_this_unit = _start_unit;					\
 	_BT_DIAG_PUSH							\
 	_BT_DIAG_IGNORE_TYPE_LIMITS					\
-	is_signed_type = _bt_is_signed_type(__typeof__(__v));		\
+	_is_signed_type = _bt_is_signed_type(__typeof__(_v));		\
 	_BT_DIAG_POP							\
-	if (is_signed_type						\
-	    && (__ptr[this_unit] & _bt_lshift((type) 1, ts - (__start % ts) - 1))) \
-		__v = ~(__typeof__(__v)) 0;				\
+	if (_is_signed_type						\
+	    && (_ptr[_this_unit] & _bt_lshift((type) 1, _ts - (_start % _ts) - 1))) \
+		_v = ~(__typeof__(_v)) 0;				\
 	else								\
-		__v = 0;						\
-	if (start_unit == end_unit - 1) {				\
-		cmask = __ptr[this_unit];				\
-		cmask = _bt_rshift(cmask, (ts - (end % ts)) % ts);	\
-		if ((end - __start) % ts) {				\
-			mask = _bt_make_mask(type, end - __start);	\
-			cmask &= mask;					\
+		_v = 0;							\
+	if (_start_unit == _end_unit - 1) {				\
+		_cmask = _ptr[_this_unit];				\
+		_cmask = _bt_rshift(_cmask, (_ts - (_end % _ts)) % _ts); \
+		if ((_end - _start) % _ts) {				\
+			_mask = _bt_make_mask(type, _end - _start);	\
+			_cmask &= _mask;				\
 		}							\
-		_bt_safe_lshift(__v, end - __start);		\
-		__v |= _bt_cast_value_to_unsigned_type(__typeof__(__v), cmask); \
-		*__vptr = __v;						\
+		_bt_safe_lshift(_v, _end - _start);			\
+		_v |= _bt_cast_value_to_unsigned_type(__typeof__(_v), _cmask); \
+		*_vptr = _v;						\
 		break;							\
 	}								\
-	if (__start % ts) {						\
-		cshift = __start % ts;					\
-		mask = _bt_make_mask(type, ts - cshift);		\
-		cmask = __ptr[this_unit];				\
-		cmask &= mask;						\
-		_bt_safe_lshift(__v, ts - cshift);			\
-		__v |= _bt_cast_value_to_unsigned_type(__typeof__(__v), cmask); \
-		__start += ts - cshift;					\
-		this_unit++;						\
+	if (_start % _ts) {						\
+		_cshift = _start % _ts;					\
+		_mask = _bt_make_mask(type, _ts - _cshift);		\
+		_cmask = _ptr[_this_unit];				\
+		_cmask &= _mask;					\
+		_bt_safe_lshift(_v, _ts - _cshift);			\
+		_v |= _bt_cast_value_to_unsigned_type(__typeof__(_v), _cmask); \
+		_start += _ts - _cshift;				\
+		_this_unit++;						\
 	}								\
-	for (; this_unit < end_unit - 1; this_unit++) {			\
-		_bt_safe_lshift(__v, ts);				\
-		__v |= _bt_cast_value_to_unsigned_type(__typeof__(__v), __ptr[this_unit]); \
-		__start += ts;						\
+	for (; _this_unit < _end_unit - 1; _this_unit++) {		\
+		_bt_safe_lshift(_v, _ts);				\
+		_v |= _bt_cast_value_to_unsigned_type(__typeof__(_v), _ptr[_this_unit]); \
+		_start += _ts;						\
 	}								\
-	if (end % ts) {							\
-		mask = _bt_make_mask(type, end % ts);			\
-		cmask = __ptr[this_unit];				\
-		cmask = _bt_rshift(cmask, ts - (end % ts));		\
-		cmask &= mask;						\
-		_bt_safe_lshift(__v, end % ts);				\
-		__v |= _bt_cast_value_to_unsigned_type(__typeof__(__v), cmask); \
+	if (_end % _ts) {						\
+		_mask = _bt_make_mask(type, _end % _ts);		\
+		_cmask = _ptr[_this_unit];				\
+		_cmask = _bt_rshift(_cmask, _ts - (_end % _ts));	\
+		_cmask &= _mask;					\
+		_bt_safe_lshift(_v, _end % _ts);			\
+		_v |= _bt_cast_value_to_unsigned_type(__typeof__(_v), _cmask); \
 	} else {							\
-		_bt_safe_lshift(__v, ts);				\
-		__v |= _bt_cast_value_to_unsigned_type(__typeof__(__v), __ptr[this_unit]); \
+		_bt_safe_lshift(_v, _ts);				\
+		_v |= _bt_cast_value_to_unsigned_type(__typeof__(_v), _ptr[_this_unit]); \
 	}								\
-	*__vptr = __v;							\
+	*_vptr = _v;							\
 } while (0)
 
 /*
@@ -522,25 +522,25 @@ do {									\
 
 #if (BYTE_ORDER == LITTLE_ENDIAN)
 
-#define bt_bitfield_read(_ptr, type, _start, _length, _vptr)		\
-	_bt_bitfield_read_le(_ptr, type, _start, _length, _vptr)
+#define bt_bitfield_read(ptr, type, start, length, vptr)		\
+	_bt_bitfield_read_le(ptr, type, start, length, vptr)
 
-#define bt_bitfield_read_le(_ptr, type, _start, _length, _vptr)		\
-	_bt_bitfield_read_le(_ptr, type, _start, _length, _vptr)
+#define bt_bitfield_read_le(ptr, type, start, length, vptr)		\
+	_bt_bitfield_read_le(ptr, type, start, length, vptr)
 
-#define bt_bitfield_read_be(_ptr, type, _start, _length, _vptr)		\
-	_bt_bitfield_read_be(_ptr, unsigned char, _start, _length, _vptr)
+#define bt_bitfield_read_be(ptr, type, start, length, vptr)		\
+	_bt_bitfield_read_be(ptr, unsigned char, start, length, vptr)
 
 #elif (BYTE_ORDER == BIG_ENDIAN)
 
-#define bt_bitfield_read(_ptr, type, _start, _length, _vptr)		\
-	_bt_bitfield_read_be(_ptr, type, _start, _length, _vptr)
+#define bt_bitfield_read(ptr, type, start, length, vptr)		\
+	_bt_bitfield_read_be(ptr, type, start, length, vptr)
 
-#define bt_bitfield_read_le(_ptr, type, _start, _length, _vptr)		\
-	_bt_bitfield_read_le(_ptr, unsigned char, _start, _length, _vptr)
+#define bt_bitfield_read_le(ptr, type, start, length, vptr)		\
+	_bt_bitfield_read_le(ptr, unsigned char, start, length, vptr)
 
-#define bt_bitfield_read_be(_ptr, type, _start, _length, _vptr)		\
-	_bt_bitfield_read_be(_ptr, type, _start, _length, _vptr)
+#define bt_bitfield_read_be(ptr, type, start, length, vptr)		\
+	_bt_bitfield_read_be(ptr, type, start, length, vptr)
 
 #else /* (BYTE_ORDER == PDP_ENDIAN) */
 
-- 
2.11.0
