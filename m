From: Hannes Weisbach <hannes.weisbach@mailbox.tu-dresden.de>
Subject: Re: [BUG] lttng-sessiond
Date: Fri, 24 Apr 2015 11:52:07 +0200
Message-ID: <DE838679-50E7-464E-B47B-934EF31813A9__34277.6318583221$1429897430$gmane$org@mailbox.tu-dresden.de>
References: <3E06425C-5C41-4BF7-8156-A62C4E9B5E60@mailbox.tu-dresden.de>
 <1230298824.35208.1429817200877.JavaMail.zimbra@efficios.com>
 <1795330554.35257.1429820009277.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: multipart/mixed; boundary="===============0170708716=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mailout1.zih.tu-dresden.de ([141.30.67.72])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <hannes.weisbach@mailbox.tu-dresden.de>)
 id 1YlaHJ-0004zM-02
 for lttng-dev@lists.lttng.org; Fri, 24 Apr 2015 05:52:13 -0400
In-Reply-To: <1795330554.35257.1429820009277.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


--===============0170708716==
Content-Type: multipart/signed; boundary="Apple-Mail=_DAD7CFBB-590F-4712-A8A9-CE341A60A78B"; protocol="application/pgp-signature"; micalg=pgp-sha1


--Apple-Mail=_DAD7CFBB-590F-4712-A8A9-CE341A60A78B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252

Hello,

>> Can you share with us the code of your "hello" probe ?
I used the example code from
http://lttng.org/docs/#doc-instrumenting-linux-kernel-itself .

>> Which version or git commit of lttng-modules are you
>> using ?
I used the current master of the github mirrors, specifically:
lttng-tools: 94ffb05d6777efc0c40394d3df44a04feed92953
lttng-modules: d0558de29ca516e83b388b8028651f8b69288e4e
lttng-ust: 4bc1ccd721114691c6f0dbd65335b3c43c9f895f

> I think the two issues should be fixed by this new
> git commit in lttng-modules master branch:
>=20
> commit 66fd8d5e4a6080f1b2db0f525c26c07e5b723aab
> Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Date:   Thu Apr 23 16:11:15 2015 -0400
>=20
>    Fix: double-unlock of session mutex
>=20
>    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>=20
> Can you give it a try ?
Yes, the mutex error goes away.  However, loading multiple probes with
either --kmod-probes or --extra-kmod-probes still does not work:
$ sudo lttng-sessiond -vvv --extra-kmod-probes=3Dsched,napi
[...]
DEBUG1 - 11:42:18.492870 [5358/5358]: Modprobe successfully =
lttng-probe-napi (in modprobe_lttng() at modprobe.c:285)
sh: 1: Syntax error: "(" unexpected
DEBUG1 - 11:42:18.495037 [5358/5358]: Unable to load optional module =
(null); continuing (in modprobe_lttng() at modprobe.c:281)
[...]

Also, lttng-probe-regmap does not compile, but that might have to do
with my kernel version of 4.0.0-rc4 (commit
b314acaccd7e0d55314d96be4a33b5f50d0b3344 from
https://github.com/torvalds/linux):

lttng-modules$ make KERNELDIR=3D/usr/src/linux-4.0.0-rc4-atlas+
make -C /usr/src/linux-4.0.0-rc4-atlas+ =
M=3D/home/hannesweisbach/atlas/lttng-modules modules
make[1]: Entering directory '/usr/src/linux-4.0.0-rc4-atlas+'
  CC [M]  =
/home/hannesweisbach/atlas/lttng-modules/probes/lttng-probe-regmap.o
In file included from =
/home/hannesweisbach/atlas/lttng-modules/probes/../instrumentation/events/=
lttng-module/../../../probes/define_trace.h:100:0,
                 from =
/home/hannesweisbach/atlas/lttng-modules/probes/../instrumentation/events/=
lttng-module/regmap.h:278,
                 from =
/home/hannesweisbach/atlas/lttng-modules/probes/lttng-probe-regmap.c:41:
=
/home/hannesweisbach/atlas/lttng-modules/probes/../instrumentation/events/=
lttng-module/../../../probes/lttng-events.h:134:6: error: conflicting =
types for =91trace_regmap_reg_write=92
 void trace_##_name(_proto);
      ^
=
/home/hannesweisbach/atlas/lttng-modules/probes/../instrumentation/events/=
lttng-module/../../../probes/lttng-events.h:99:2: note: in expansion of =
macro =91LTTNG_TRACEPOINT_EVENT_INSTANCE_MAP=92
  LTTNG_TRACEPOINT_EVENT_INSTANCE_MAP(template, name, name, =
PARAMS(proto), PARAMS(args))
  ^
=
/home/hannesweisbach/atlas/lttng-modules/probes/../instrumentation/events/=
lttng-module/../../../probes/../instrumentation/events/lttng-module/regmap=
.h:34:1: note: in expansion of macro =91LTTNG_TRACEPOINT_EVENT_INSTANCE=92=

 LTTNG_TRACEPOINT_EVENT_INSTANCE(regmap_reg, regmap_reg_write,
 ^
In file included from include/trace/events/regmap.h:8:0,
                 from =
/home/hannesweisbach/atlas/lttng-modules/probes/lttng-probe-regmap.c:32:
include/linux/tracepoint.h:169:21: note: previous definition of =
=91trace_regmap_reg_write=92 was here
  static inline void trace_##name(proto)    \
                     ^
include/linux/tracepoint.h:325:3: note: in expansion of macro =
=91__DECLARE_TRACE=92
   __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args), 1, \
   ^
include/linux/tracepoint.h:448:2: note: in expansion of macro =
=91DECLARE_TRACE=92
  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
  ^
include/trace/events/regmap.h:40:1: note: in expansion of macro =
=91DEFINE_EVENT=92
 DEFINE_EVENT(regmap_reg, regmap_reg_write,
 ^

[ and so on, and so on =85 ]

Since I don't need the regmap probe I simply disabled it in
probes/Makefile.  Unfortunately, I don't have time to debug it myself.
If you want me to try another version, let me know.

Best regards,
Hannes


--Apple-Mail=_DAD7CFBB-590F-4712-A8A9-CE341A60A78B
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iEYEARECAAYFAlU6EkgACgkQ74te23KpN+n4qwCcCVMm9zHmSSZnVdg2G1H3Yisg
1C8AoISpaWFvfx86wYQodv3HcsjzixNU
=zRXX
-----END PGP SIGNATURE-----

--Apple-Mail=_DAD7CFBB-590F-4712-A8A9-CE341A60A78B--


--===============0170708716==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0170708716==--
