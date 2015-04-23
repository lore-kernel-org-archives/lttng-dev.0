From: Hannes Weisbach <hannes.weisbach@mailbox.tu-dresden.de>
Subject: [BUG] lttng-sessiond
Date: Thu, 23 Apr 2015 12:04:04 +0200
Message-ID: <3E06425C-5C41-4BF7-8156-A62C4E9B5E60__35580.826996784$1429804988$gmane$org@mailbox.tu-dresden.de>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: multipart/mixed; boundary="===============1052452971=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mailout1.zih.tu-dresden.de ([141.30.67.72])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <hannes.weisbach@mailbox.tu-dresden.de>)
 id 1YlDzJ-0005p4-2A
 for lttng-dev@lists.lttng.org; Thu, 23 Apr 2015 06:04:12 -0400
Received: from mail.zih.tu-dresden.de ([141.76.14.4])
 by mailout1.zih.tu-dresden.de with esmtp (Exim 4.63)
 (envelope-from <hannes.weisbach@mailbox.tu-dresden.de>)
 id 1YlDzH-0004dp-Pn
 for lttng-dev@lists.lttng.org; Thu, 23 Apr 2015 12:04:03 +0200
Received: from [141.76.49.4] (helo=os-dhcp004.inf.tu-dresden.de)
 by server-50.mailclusterdns.zih.tu-dresden.de with esmtpsa
 (TLSv1:AES128-SHA:128)
 (envelope-from <hannes.weisbach@mailbox.tu-dresden.de>)
 id 1YlDzH-00048w-Jc
 for lttng-dev@lists.lttng.org; Thu, 23 Apr 2015 12:04:03 +0200
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


--===============1052452971==
Content-Type: multipart/signed; boundary="Apple-Mail=_BCC5FD06-9C9B-4132-A23E-A2E0ACB071C2"; protocol="application/pgp-signature"; micalg=pgp-sha1


--Apple-Mail=_BCC5FD06-9C9B-4132-A23E-A2E0ACB071C2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hello,

I'm using LTTng with a kernel that has lock debugging enabled.  I
familiarized myself with LTTng using the "Hello world" example, where
I encountered two bugs.

1) Using multiple probes for the lttng-sessiond arguments
--kmod-probes and --extra-kmod-probes does not work:

$ sudo lttng-sessiond --kmod-probes=3D"hello,sched" -vvv
[...]
DEBUG1 - 11:54:22.413830 [17827/17827]: Modprobe successfully =
lttng-probe-sched (in modprobe_lttng() at modprobe.c:285)
sh: 1: Syntax error: "(" unexpected
DEBUG1 - 11:54:22.415273 [17827/17827]: Unable to load optional module =
(null); continuing (in modprobe_lttng() at modprobe.c:281)
[...]

$ sudo lttng-sessiond --kmod-probes=3D"sched,hello" -vvv
[...]
DEBUG1 - 11:55:13.879976 [17896/17896]: Modprobe successfully =
lttng-probe-hello (in modprobe_lttng() at modprobe.c:285)
sh: 1: Syntax error: "(" unexpected
DEBUG1 - 11:55:13.881183 [17896/17896]: Unable to load optional module =
(null); continuing (in modprobe_lttng() at modprobe.c:281)
[...]

$ sudo lttng-sessiond --extra-kmod-probes=3D"sched,hello" -vvv
[...]
DEBUG1 - 11:55:54.244515 [17966/17966]: Modprobe successfully =
lttng-probe-hello (in modprobe_lttng() at modprobe.c:285)
sh: 1: Syntax error: "(" unexpected
DEBUG1 - 11:55:54.245758 [17966/17966]: Unable to load optional module =
(null); continuing (in modprobe_lttng() at modprobe.c:281)
[...]

It seems, only the last argument (module) is loaded correctly.

2) Having lttng-sessiond started:
$ sudo lttng-sessiond --kmod-probes=3Dhello
And the tracer configured:
lttng create
lttng enable-event hello_world -k

'lttng start' causes a locking failure to be reported:
[  159.783420]
[  159.783922] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  159.784067] [ BUG: bad unlock balance detected! ]
[  159.784067] 4.0.0-rc4-atlas+ #200 Tainted: G           O
[  159.784067] -------------------------------------
[  159.784067] lttng-sessiond/1441 is trying to release lock =
(sessions_mutex) at:
[  159.784067] [<ffffffff81808c3e>] mutex_unlock+0xe/0x10
[  159.784067] but there are no more locks to release!
[  159.784067]
[  159.784067] other info that might help us debug this:
[  159.784067] no locks held by lttng-sessiond/1441.
[  159.784067]
[  159.784067] stack backtrace:
[  159.784067] CPU: 0 PID: 1441 Comm: lttng-sessiond Tainted: G          =
 O    4.0.0-rc4-atlas+ #200
[  159.784067] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), =
BIOS Bochs 01/01/2011
[  159.784067]  ffffffff81808c3e ffff88005d24fa28 ffffffff818029e0 =
0000000000000007
[  159.784067]  ffff880057c9cd60 ffff88005d24fa58 ffffffff810c1924 =
ffff88005d24fad8
[  159.784067]  ffff880057c9cd60 ffffffffa01ce070 ffffffff81808c3e =
ffff88005d24fa98
[  159.784067] Call Trace:
[  159.784067]  [<ffffffff81808c3e>] ? mutex_unlock+0xe/0x10
[  159.784067]  [<ffffffff818029e0>] dump_stack+0x4c/0x65
[  159.784067]  [<ffffffff810c1924>] =
print_unlock_imbalance_bug+0xf4/0x100
[  159.784067]  [<ffffffff81808c3e>] ? mutex_unlock+0xe/0x10
[  159.784067]  [<ffffffff810c6986>] lock_release+0x2e6/0x460
[  159.784067]  [<ffffffff81808b16>] __mutex_unlock_slowpath+0x76/0x190
[  159.784067]  [<ffffffff81808c3e>] mutex_unlock+0xe/0x10
[  159.784067]  [<ffffffffa00bcc98>] lttng_session_enable+0x208/0x5b0 =
[lttng_tracer]
[  159.784067]  [<ffffffffa00bdd75>] lttng_session_ioctl+0x155/0x300 =
[lttng_tracer]
[  159.784067]  [<ffffffff810c3a80>] ? __lock_acquire+0x570/0x1f60
[  159.784067]  [<ffffffff8109d095>] ? sched_clock_local+0x25/0x90
[  159.784067]  [<ffffffff811d41c7>] ? do_wp_page+0x3a7/0x900
[  159.784067]  [<ffffffff8109d2d8>] ? sched_clock_cpu+0x98/0xc0
[  159.784067]  [<ffffffff8109d355>] ? local_clock+0x15/0x30
[  159.784067]  [<ffffffff8109d095>] ? sched_clock_local+0x25/0x90
[  159.784067]  [<ffffffff811d41c7>] ? do_wp_page+0x3a7/0x900
[  159.784067]  [<ffffffff810c3a80>] ? __lock_acquire+0x570/0x1f60
[  159.784067]  [<ffffffff811d41c7>] ? do_wp_page+0x3a7/0x900
[  159.784067]  [<ffffffff811d5820>] ? handle_mm_fault+0x310/0x18b0
[  159.784067]  [<ffffffff8109d095>] ? sched_clock_local+0x25/0x90
[  159.784067]  [<ffffffff8109d095>] ? sched_clock_local+0x25/0x90
[  159.784067]  [<ffffffff81248e41>] ? __fget+0x111/0x260
[  159.784067]  [<ffffffff8109d2d8>] ? sched_clock_cpu+0x98/0xc0
[  159.784067]  [<ffffffff8109d355>] ? local_clock+0x15/0x30
[  159.784067]  [<ffffffff81248e41>] ? __fget+0x111/0x260
[  159.784067]  [<ffffffff8123c998>] do_vfs_ioctl+0x308/0x560
[  159.784067]  [<ffffffff81248d35>] ? __fget+0x5/0x260
[  159.784067]  [<ffffffff8104f201>] ? __do_page_fault+0x1f1/0x4c0
[  159.784067]  [<ffffffff8123cc71>] SyS_ioctl+0x81/0xa0
[  159.784067]  [<ffffffff8180cfb6>] system_call_fastpath+0x16/0x1b

I hope this helps.

--=20
Best regards,
Hannes

--Apple-Mail=_BCC5FD06-9C9B-4132-A23E-A2E0ACB071C2
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iEYEARECAAYFAlU4w5UACgkQ74te23KpN+mhaACfQZulXXvZm66o7+P2BVFg5kFV
Q3wAn2KXnMFyrouqNQ6KJOSAuqcwJVwf
=OSeE
-----END PGP SIGNATURE-----

--Apple-Mail=_BCC5FD06-9C9B-4132-A23E-A2E0ACB071C2--


--===============1052452971==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1052452971==--
