From: David Goulet <dgoulet@efficios.com>
Subject: Re: =?utf-8?b?5Zue5aSN77yaIGhvdyBkb2VzIHVzdCB0cmFjZXIg?=
 =?utf-8?q?map_share_lttng_buffer?=
Date: Sat, 16 Nov 2013 08:42:15 -0500
Message-ID: <20131116134215.GA7300__2332.68953529677$1384609387$gmane$org@thessa>
References: <tencent_4B722D17200DC9B17B45EFF3@qq.com>
	<414012525.68357.1384535175855.JavaMail.zimbra@efficios.com>
	<tencent_778EC52B229ABB7013AB0416@qq.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1124337660=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1Vhg8m-00059S-4i
	for lttng-dev@lists.lttng.org; Sat, 16 Nov 2013 08:42:26 -0500
In-Reply-To: <tencent_778EC52B229ABB7013AB0416@qq.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?utf-8?B?6I2J5pyo56eA?= <39017736@qq.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org


--===============1124337660==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 16 Nov (07:18:45), =E8=8D=89=E6=9C=A8=E7=A7=80 wrote:
> >Indeed, from a sessiond point of view, this will typically use the same =
FD number, but it's really associated with a different posix SHM each time.
>=20
>=20
>   Yes,what confused me the most is that sessiond sends the same FD number=
 to UST every time,but UST receives the different FD number each time and c=
an map it to the right per-cpu share buffer sucessfully.

Yes, in per UID buffers, for every application using UST we send the FD
corresponding to the already allocated buffer (being per UID).

Please note that sending a FD through a Unix socket dups it so basically
UST receives that, access the shared memory buffer and can then operate
correctly.

Cheers!
David

>=20
>=20
> Thanks
> MuXiu.Cao
>=20
>=20
>=20
>=20
>=20
> From: "=E8=8D=89=E6=9C=A8=E7=A7=80" <39017736@qq.com>
> To: "mathieu.desnoyers" <mathieu.desnoyers@efficios.com>
> Sent: Friday, November 15, 2013 11:37:11 AM
> Subject: how does ust tracer map share lttng buffer
>=20
>=20
> Hi,Mathieu
>=20
>=20
>    After lttng sub-command enable-event is issued at first time, lttng-co=
nsumerd will be informed by lttng-sessiond to open and mmap share memory re=
gions .Then lttng-sessiond get all shmfds from lttng-consumerd.But how does=
 ust tracer map to these share memory regions?
>=20
>=20
>   AFAIK,lttng-sessiond will call  do_consumer_create_channel()  ,then sen=
d_channel_uid_to_ust(). What's confused me is in send_channel_uid_to_ust(),=
lttng-sessiond dup() one shmfd , then ust_consumer_send_stream_to_ust() to =
ust tracer, then close the shmfd and loop all shmfds. So all duped fds are =
the same fd-number (say A)and send to ust tracer through ust_consumer_send_=
stream_to_ust()->ustctl_send_stream_to_ust()->ustctl_send_stream()->ustcomm=
_send_fds_unix_sock()(unix socket is $HOME/.lttng/lttng-ust-sock-5).Why doe=
s it send the same fds to ust tracer?
>   At ust tracer side,it calls handle_message()->ustcomm_recv_stream_from_=
sessiond() and mmap every received fd to share memory region.However,every =
received fd is different from A.So I must miss something anywhere.How does =
ust tracer map share lttng buffer?
>=20
>=20
> In lttng-sessiond, we send file descriptors for each posix SHM associated=
 to every per-cpu buffer to the application over unix socket. So it's more =
or less : receive FD from consumer, send FD over unix socket to UST, close =
FD (we loop on this). Indeed, from a sessiond point of view, this will typi=
cally use the same FD number, but it's really associated with a different p=
osix SHM each time. David can probably answer your question in more detail.
>=20
>=20
>=20
> Thanks,
>=20
>=20
>=20
> Mathieu
>=20
>=20
>=20
>=20
>=20
>=20
>=20
> PS:code is from lttng-2.3.0 .
>=20
>=20
> Thanks
> MuXiu.Cao
>=20
>=20
>=20
>=20
>=20
>=20
>=20
> --=20
>=20
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQF8BAEBAgBmBQJSh3Y3XxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02HFEH/iVlq61p4EMpAzt6tXTd5LEO
9Ng3cfHE9TRecPvnragwo7WPg5KnH1gk55veFUQOfAHbVVekSg9nrIf7AmULoof7
mRhha47TAsOWfPDdNDYPHfTRzLddrAaBaKY8dO7Ydxx3sP4eM0wEerVUJMIYpjFS
pJY/KzWMeldS7Afbmi5qvE8TKceGiAh/rk8XAaC/aKebkIblfYuMR5d68fz+KdGv
6IG3ZTh4VDGk5haTs3O3V7g1HgrHhWySc9moXy4AIklDFKmHOPw5NB3gUu+ZtepA
alAgjgVbCFULe9Odz2GgUug551I5/Lb+ip3fV4K5+W5NwaYehPlkoH87SsrD05c=
=cuhS
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--


--===============1124337660==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1124337660==--
