From: David Goulet <dgoulet@efficios.com>
Subject: Re: epoll_wait reboot kernel? [or --disable-epoll
 causes lttng-sessiond assert]
Date: Mon, 3 Mar 2014 09:43:22 -0500
Message-ID: <20140303144322.GA7842__47447.6984273226$1393857855$gmane$org@thessa>
References: <c3d1fc94-92e2-43b3-af78-6315aaa7419d@aliyun.com,
	a860adc0-d68a-4a1e-bbd1-775c1cf652e9@aliyun.com>
	<494972cb-79c7-4197-981c-d682306d585e@aliyun.com>
	<6cab5c14-9ef8-4a13-a134-a4b628ddc35d@aliyun.com>
	<20998D40D9A2B7499CA5A3A2666CB1EB2A67A4EE@ZURMSG1.QUANTUM.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1252259438=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1WKU5b-0005GJ-NY
	for lttng-dev@lists.lttng.org; Mon, 03 Mar 2014 09:43:33 -0500
In-Reply-To: <20998D40D9A2B7499CA5A3A2666CB1EB2A67A4EE@ZURMSG1.QUANTUM.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David OShea <David.OShea@quantum.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org


--===============1252259438==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 03 Mar (10:17:11), David OShea wrote:
> Hi all,
>=20
> Apologies if I'm confusing things, but I think my issue may be related.  =
Please see below:
>=20
> > -----Original Message-----
> > From: zhenyu.ren [mailto:zhenyu.ren@aliyun.com]
> > Sent: Tuesday, 25 February 2014 4:32 PM
> > To: Mathieu Desnoyers
> > Cc: lttng-dev
> > Subject: Re: [lttng-dev] epoll_wait reboot kernel?
> >=20
> > >Which gcc version do you use ?
> > $gcc --version
> > gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-46)
>=20
> I'm on CentOS 6, so my results ought to be relevant, but the above looks =
like the default GCC version for EL5, not EL6.  I'm using "gcc (GCC) 4.4.7 =
20120313 (Red Hat 4.4.7-4)".
>=20
> [...]
> > >  >  I am working on rhel6(2.6.32.220) and ust is working very
> > well.But when I
> > >  >  use lttng-modules (after "lttng start"),the kernel reboots
> > immediately
> > >  >  >without any message output to console.
>=20
> I'm not using the kernel modules here, just lttng-ust.
>=20
> [...]
> > > > I want to use poll instead as epoll in lttng-tools ,I changed
> > lttng-tools
> > > > configure file to not use epoll(undef HAVE_EPOLL),
>=20
> Note that 'configure' for lttng-tools has a --disable-epoll option.
>=20
> > > > but "lttng enable-event
> > > > -a -k >"failed :(Do I miss anything?)
> > > >#lttng enable-event -a -k
> > > >DEBUG1 [17837/18080]: Using run_as_clone (in run_as() at
> > runas.c:293)
> > > >lttng-sessiond: ht-cleanup.c:92: thread_ht_cleanup: Assertion
> > `pollfd =3D=3D
> > > >ht_cleanup_pipe[0]' failed.
>=20
> I get similar issues when I run 'lttng enable-event -a -u' (i.e. UST inst=
ead of kernel tracing):
>=20
> DEBUG1 [1292/1297]: Spawning consumerd (in spawn_consumerd() at main.c:20=
85)
> lttng-sessiond: ht-cleanup.c:92: thread_ht_cleanup: Assertion `pollfd =3D=
=3D ht_cleanup_pipe[0]' failed.
> DEBUG1 [1329/1329]: Using 64-bit UST consumer at: /usr/lib64/lttng/libexe=
c/lttng-consumerd (in spawn_consumerd() at main.c:2161)
> Aborted (core dumped)

Can you open a bug at bugs.lttng.org about that (if not already done)
and provide the "bt full" of your coredump. That would be very helpful
to us to address this issue.

Thanks!
David

>=20
> but only when I configure lttng-tools with --disable-epoll.  If I remove =
that option at build time, that particular lttng-sessiond assertion failure=
 goes away and UST works fine.
>=20
> I built with --disable-epoll because I was told that, at least in some pr=
evious LTTng version, this was necessary for building on CentOS 5.  I guess=
 I can stop doing that now I'm using CentOS 6, but should this happen or is=
 there a bug here?
>=20
> > > >PS:.lttng(ust/module/tool) version is 2.3.0 and urcu version is 0.8
>=20
> I'm using lttng-ust, lttng-tools 2.3.2 and userspace-rcu 0.8.3.
>=20
> Thanks in advance,
> David
>=20
> ----------------------------------------------------------------------
> The information contained in this transmission may be confidential. Any d=
isclosure, copying, or further distribution of confidential information is =
not permitted unless such privilege is explicitly granted in writing by Qua=
ntum. Quantum reserves the right to have electronic communications, includi=
ng email and attachments, sent across its networks filtered through anti vi=
rus and spam software programs and retain such messages in order to comply =
with applicable data security and retention requirements. Quantum is not re=
sponsible for the proper and complete transmission of the substance of this=
 communication or for any delay in its receipt.
>=20
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJTFJUKXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02KKAIAL+dGCptUWxyjFDRk0CNReeq
ae71sUTl6SRvYuT5IUUh2rc4cY4t6JFr9KEOw8zb/+WsuWVy50fDPuKpCZ8icrsq
UjRxi/VSy/o8kJQfGU6ORMRbUgVl5hOOq2dZsGD5Dd9NUMSiXZAza7AUj/ojYVBQ
YBicIhQgD0SzBFq7IJg6npZrjLoLdXoLmgtqvw+ImsRvi39GmKKP3/PtbepVYdjd
h1iXAUrBHrvuj3pkO7CpNn0F6DdGG3SNstSgcxBILk7wsrpPgnQpRHoOkT1aGGfG
USqWq4inXbtAhU5Wx6IurrUiF8BjEJRTnhTC06i9Bk1rD4DMlT+foabqzMayuzM=
=Owe6
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--


--===============1252259438==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1252259438==--
