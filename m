From: Khem Raj <raj.khem@gmail.com>
Subject: Re: [PATCH] uatomic: Specify complete types for atomic
	function calls
Date: Mon, 24 Aug 2015 10:21:11 -0700
Message-ID: <91ED9104-5F58-4B4B-AF3C-3C2B6BC8018D__30137.4470153407$1440441554$gmane$org@gmail.com>
References: <1440304710-5312-1-git-send-email-raj.khem@gmail.com>
 <640961998.27803.1440433441071.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: multipart/mixed; boundary="===============1680467352=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <raj.khem@gmail.com>) id 1ZTvQw-0000kh-7w
 for lttng-dev@lists.lttng.org; Mon, 24 Aug 2015 13:21:26 -0400
Received: by pacdd16 with SMTP id dd16so101512979pac.2
 for <lttng-dev@lists.lttng.org>; Mon, 24 Aug 2015 10:21:16 -0700 (PDT)
In-Reply-To: <640961998.27803.1440433441071.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org


--===============1680467352==
Content-Type: multipart/signed; boundary="Apple-Mail=_E5FF1C85-3CA9-42D5-B618-A25CC5CC3654"; protocol="application/pgp-signature"; micalg=pgp-sha1


--Apple-Mail=_E5FF1C85-3CA9-42D5-B618-A25CC5CC3654
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On Aug 24, 2015, at 9:24 AM, Mathieu Desnoyers =
<mathieu.desnoyers@efficios.com> wrote:
>=20
> Merged into master, stable-0.8, stable-0.7.
>=20
> I edited the patch to use stdint.h types instead.
>=20

ah yes. thats better.

> Thanks!
>=20
> Mathieu
>=20
> ----- On Aug 23, 2015, at 12:38 AM, Khem Raj raj.khem@gmail.com wrote:
>=20
>> This was unearthed by clang compiler where it complained about =
parameter
>> mismatch, gcc doesnt notice this
>>=20
>> urcu/uatomic/generic.h:190:10: error: address argument to atomic =
builtin
>> must be a pointer to integer or pointer ('void *' invalid)
>>               return __sync_add_and_fetch_4(addr, val);
>>=20
>> Fixed all instances thusly
>>=20
>> Signed-off-by: Khem Raj <raj.khem@gmail.com>
>> ---
>> urcu/uatomic/generic.h | 40 ++++++++++++++++++++--------------------
>> 1 file changed, 20 insertions(+), 20 deletions(-)
>>=20
>> diff --git a/urcu/uatomic/generic.h b/urcu/uatomic/generic.h
>> index 37f59cc..0046ffd 100644
>> --- a/urcu/uatomic/generic.h
>> +++ b/urcu/uatomic/generic.h
>> @@ -65,17 +65,17 @@ unsigned long _uatomic_cmpxchg(void *addr, =
unsigned long
>> old,
>> 	switch (len) {
>> #ifdef UATOMIC_HAS_ATOMIC_BYTE
>> 	case 1:
>> -		return __sync_val_compare_and_swap_1(addr, old, _new);
>> +		return __sync_val_compare_and_swap_1((unsigned char =
*)addr, old, _new);
>> #endif
>> #ifdef UATOMIC_HAS_ATOMIC_SHORT
>> 	case 2:
>> -		return __sync_val_compare_and_swap_2(addr, old, _new);
>> +		return __sync_val_compare_and_swap_2((unsigned short int =
*)addr, old, _new);
>> #endif
>> 	case 4:
>> -		return __sync_val_compare_and_swap_4(addr, old, _new);
>> +		return __sync_val_compare_and_swap_4((unsigned int =
*)addr, old, _new);
>> #if (CAA_BITS_PER_LONG =3D=3D 64)
>> 	case 8:
>> -		return __sync_val_compare_and_swap_8(addr, old, _new);
>> +		return __sync_val_compare_and_swap_8((unsigned long =
*)addr, old, _new);
>> #endif
>> 	}
>> 	_uatomic_link_error();
>> @@ -100,20 +100,20 @@ void _uatomic_and(void *addr, unsigned long =
val,
>> 	switch (len) {
>> #ifdef UATOMIC_HAS_ATOMIC_BYTE
>> 	case 1:
>> -		__sync_and_and_fetch_1(addr, val);
>> +		__sync_and_and_fetch_1((unsigned char *)addr, val);
>> 		return;
>> #endif
>> #ifdef UATOMIC_HAS_ATOMIC_SHORT
>> 	case 2:
>> -		__sync_and_and_fetch_2(addr, val);
>> +		__sync_and_and_fetch_2((unsigned short int *)addr, val);
>> 		return;
>> #endif
>> 	case 4:
>> -		__sync_and_and_fetch_4(addr, val);
>> +		__sync_and_and_fetch_4((unsigned int *)addr, val);
>> 		return;
>> #if (CAA_BITS_PER_LONG =3D=3D 64)
>> 	case 8:
>> -		__sync_and_and_fetch_8(addr, val);
>> +		__sync_and_and_fetch_8((unsigned long *)addr, val);
>> 		return;
>> #endif
>> 	}
>> @@ -139,20 +139,20 @@ void _uatomic_or(void *addr, unsigned long val,
>> 	switch (len) {
>> #ifdef UATOMIC_HAS_ATOMIC_BYTE
>> 	case 1:
>> -		__sync_or_and_fetch_1(addr, val);
>> +		__sync_or_and_fetch_1((unsigned char *)addr, val);
>> 		return;
>> #endif
>> #ifdef UATOMIC_HAS_ATOMIC_SHORT
>> 	case 2:
>> -		__sync_or_and_fetch_2(addr, val);
>> +		__sync_or_and_fetch_2((unsigned short int *)addr, val);
>> 		return;
>> #endif
>> 	case 4:
>> -		__sync_or_and_fetch_4(addr, val);
>> +		__sync_or_and_fetch_4((unsigned int *)addr, val);
>> 		return;
>> #if (CAA_BITS_PER_LONG =3D=3D 64)
>> 	case 8:
>> -		__sync_or_and_fetch_8(addr, val);
>> +		__sync_or_and_fetch_8((unsigned long *)addr, val);
>> 		return;
>> #endif
>> 	}
>> @@ -180,17 +180,17 @@ unsigned long _uatomic_add_return(void *addr, =
unsigned
>> long val,
>> 	switch (len) {
>> #ifdef UATOMIC_HAS_ATOMIC_BYTE
>> 	case 1:
>> -		return __sync_add_and_fetch_1(addr, val);
>> +		return __sync_add_and_fetch_1((unsigned char *)addr, =
val);
>> #endif
>> #ifdef UATOMIC_HAS_ATOMIC_SHORT
>> 	case 2:
>> -		return __sync_add_and_fetch_2(addr, val);
>> +		return __sync_add_and_fetch_2((unsigned short int =
*)addr, val);
>> #endif
>> 	case 4:
>> -		return __sync_add_and_fetch_4(addr, val);
>> +		return __sync_add_and_fetch_4((unsigned int *)addr, =
val);
>> #if (CAA_BITS_PER_LONG =3D=3D 64)
>> 	case 8:
>> -		return __sync_add_and_fetch_8(addr, val);
>> +		return __sync_add_and_fetch_8((unsigned long *)addr, =
val);
>> #endif
>> 	}
>> 	_uatomic_link_error();
>> @@ -218,7 +218,7 @@ unsigned long _uatomic_exchange(void *addr, =
unsigned long
>> val, int len)
>>=20
>> 		do {
>> 			old =3D uatomic_read((unsigned char *)addr);
>> -		} while (!__sync_bool_compare_and_swap_1(addr, old, =
val));
>> +		} while (!__sync_bool_compare_and_swap_1((unsigned char =
*)addr, old, val));
>>=20
>> 		return old;
>> 	}
>> @@ -230,7 +230,7 @@ unsigned long _uatomic_exchange(void *addr, =
unsigned long
>> val, int len)
>>=20
>> 		do {
>> 			old =3D uatomic_read((unsigned short *)addr);
>> -		} while (!__sync_bool_compare_and_swap_2(addr, old, =
val));
>> +		} while (!__sync_bool_compare_and_swap_2((unsigned short =
int *)addr, old,
>> val));
>>=20
>> 		return old;
>> 	}
>> @@ -241,7 +241,7 @@ unsigned long _uatomic_exchange(void *addr, =
unsigned long
>> val, int len)
>>=20
>> 		do {
>> 			old =3D uatomic_read((unsigned int *)addr);
>> -		} while (!__sync_bool_compare_and_swap_4(addr, old, =
val));
>> +		} while (!__sync_bool_compare_and_swap_4((unsigned int =
*)addr, old, val));
>>=20
>> 		return old;
>> 	}
>> @@ -252,7 +252,7 @@ unsigned long _uatomic_exchange(void *addr, =
unsigned long
>> val, int len)
>>=20
>> 		do {
>> 			old =3D uatomic_read((unsigned long *)addr);
>> -		} while (!__sync_bool_compare_and_swap_8(addr, old, =
val));
>> +		} while (!__sync_bool_compare_and_swap_8((unsigned long =
*)addr, old, val));
>>=20
>> 		return old;
>> 	}
>> --
>> 2.1.4
>>=20
>>=20
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>=20
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com


--Apple-Mail=_E5FF1C85-3CA9-42D5-B618-A25CC5CC3654
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iEYEARECAAYFAlXbUosACgkQuwUzVZGdMxTc1QCfbr6pC/jIQ3PZCEFTomzqpHwB
IyQAnigsVpakoG7hUF3EiTuVIad6+yPw
=IxR9
-----END PGP SIGNATURE-----

--Apple-Mail=_E5FF1C85-3CA9-42D5-B618-A25CC5CC3654--


--===============1680467352==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1680467352==--
