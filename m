From: Hannes Weisbach <hannes.weisbach@mailbox.tu-dresden.de>
Subject: Re: [BUG] lttng-sessiond
Date: Sat, 25 Apr 2015 16:13:11 +0200
Message-ID: <4DCF299D-B929-42DB-B514-5219DAF3105F__21934.5846133821$1430001638$gmane$org@mailbox.tu-dresden.de>
References: <3E06425C-5C41-4BF7-8156-A62C4E9B5E60@mailbox.tu-dresden.de>
 <1230298824.35208.1429817200877.JavaMail.zimbra@efficios.com>
 <1795330554.35257.1429820009277.JavaMail.zimbra@efficios.com>
 <DE838679-50E7-464E-B47B-934EF31813A9@mailbox.tu-dresden.de>
 <480136718.35882.1429900335415.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: multipart/mixed; boundary="===============0176931093=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mailout1.zih.tu-dresden.de ([141.30.67.72])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <hannes.weisbach@mailbox.tu-dresden.de>)
 id 1Ym0pW-0005PV-UM
 for lttng-dev@lists.lttng.org; Sat, 25 Apr 2015 10:13:19 -0400
In-Reply-To: <480136718.35882.1429900335415.JavaMail.zimbra@efficios.com>
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


--===============0176931093==
Content-Type: multipart/signed; boundary="Apple-Mail=_EDCED187-306E-43FE-94EA-FBDBA8BEEE2C"; protocol="application/pgp-signature"; micalg=pgp-sha1


--Apple-Mail=_EDCED187-306E-43FE-94EA-FBDBA8BEEE2C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252

>> However, loading multiple probes with
>> either --kmod-probes or --extra-kmod-probes still does not work:
>> $ sudo lttng-sessiond -vvv --extra-kmod-probes=3Dsched,napi
>> [...]
>> DEBUG1 - 11:42:18.492870 [5358/5358]: Modprobe successfully =
lttng-probe-napi
>> (in modprobe_lttng() at modprobe.c:285)
>> sh: 1: Syntax error: "(" unexpected
>> DEBUG1 - 11:42:18.495037 [5358/5358]: Unable to load optional module =
(null);
>> continuing (in modprobe_lttng() at modprobe.c:281)
>> [...]
>=20
> Why do you need to load those explicitly ? They should be
> already loaded by default. I don't get those errors here.
I don't need them.  They're just examples.  Albeit they are loaded by
default, using --kmod-probes or --extra-kmod-probes should work, no?

> Which shell are you using (sh symlink) ? Can you reproduce
> using bash ?
I added a bit of debug output, namely the string that gets passed to
system(): DBG("system(%s)", modprobe);

Result:
$ sudo lttng-sessiond -vvv --kmod-probes=3D"sched,napi"
[=85]
DEBUG1 - 16:02:21.372257 [4227/4227]: system(/sbin/modprobe -q =
lttng-probe-napi) (in modprobe_lttng() at modprobe.c:263)
DEBUG1 - 16:02:21.381980 [4227/4227]: Modprobe successfully =
lttng-probe-napi (in modprobe_lttng() at modprobe.c:286)
DEBUG1 - 16:02:21.382306 [4227/4227]: system(/sbin/modprobe -q (null)) =
(in modprobe_lttng() at modprobe.c:263)
sh: 1: Syntax error: "(" unexpected
DEBUG1 - 16:02:21.384942 [4227/4227]: Unable to load optional module =
(null); continuing (in modprobe_lttng() at modprobe.c:282)

The problem is not with sh.  It is that a NULL pointer is passed to
snprintf in modprobe.c:254.  My guess is, that splitting the argument
of --kmod-probes and --extra-kmod-probes (probably using strtok) is
somehow broken.  If you can tell where in the source of lttng-sessiond
argument parsing happens I can step through the code to see what
is going on.

Best regards,
Hannes

--Apple-Mail=_EDCED187-306E-43FE-94EA-FBDBA8BEEE2C
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iEYEARECAAYFAlU7oPcACgkQ74te23KpN+lC+QCeLg5c6NbCeVFeXpSHBjJhhtGY
kikAoJCXp+KKzXxrpPTn7t9Z+K4XHHIP
=LnE3
-----END PGP SIGNATURE-----

--Apple-Mail=_EDCED187-306E-43FE-94EA-FBDBA8BEEE2C--


--===============0176931093==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0176931093==--
