From: David Goulet <dgoulet@efficios.com>
Subject: Re: Announcing sysdig: a new take on system
 instrumentation
Date: Thu, 3 Apr 2014 14:11:53 -0400
Message-ID: <20140403181153.GC9339__28922.2825821073$1396548786$gmane$org@thessa>
References: <48CF5AC71E61DB46B70D0F388054EFFD35992F74@VAL-E-02.valcartier.drdc-rddc.gc.ca>
 <533D9B59.4050700@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0323670812=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1WVm7R-0002Uv-JV
 for lttng-dev@lists.lttng.org; Thu, 03 Apr 2014 14:12:11 -0400
In-Reply-To: <533D9B59.4050700@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Loris Degioanni <loris@degio.org>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org


--===============0323670812==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f0KYrhQ4vYSV2aJu"
Content-Disposition: inline


--f0KYrhQ4vYSV2aJu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Loris,

I have to say that I'm quite impress with the analysis tool you guys
have (Chisel).

Quick very useful command for monitoring use cases, very nice stuff.

Question time! Have you at some point consider using LTTng toolchain for
the tracing part? Using the lttng-modules for your probes, lttng-ctl for
tracing control, etc... ?

There is one thing I can see that you do have that we don't and it's the
ability to extract the data from the syscall payload so I guess that
might have been a limitation with LTTng. I'm curious what are you tought
on LTTng vis-a-vis sysdig.

Do you have plans to have support for "sysdig MYAPP" like strace does
which would filter events based on MYAPP pid/name? Because with that, we
can retire strace :). This is something we are working towards with
LTTng, a "lttng trace MYAPP" command that live print the trace.

Your project is quite close to some LTTng features so I'm wondering here
how can we bridge the gaps (if we can).

Anyway, good job and congrats for this first release! :)

Cheers!
David

On 03 Apr (10:33:13), Loris Degioanni wrote:
> I=E2=80=99d like to announce sysdig, a new open source project that I bel=
ieve could
> be interesting to the LTTng community. Sysdig is designed to offer a nove=
l,
> Wireshark-like approach to system tracing.
>=20
> http://www.sysdig.org/
> https://github.com/draios/sysdig
>=20
> Sysdig is similar to lttng from the instrumentation point of view, but is
> like a mix between tcpdump, strace and lsof. It adds a set of layers on t=
op
> of traditional kernel-level instrumentation to reconstruct state, decode =
and
> filter information.
>=20
> It comes packed with a set of pretty cool features: the ability to create
> system trace files in the wireshark-compatible pcap-ng format, an easy to
> use filtering language, scripting in Lua, and a libpcap-like capture libr=
ary
> that can be used to build new tools on top of the capture infrastructure.
>=20
> I=E2=80=99d love to hear what you all think. And, if you do enjoy using s=
ysdig, we
> could really use your help spreading the word.
>=20
> Thanks!
>=20
>=20
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--f0KYrhQ4vYSV2aJu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJTPaRpXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I0230MIAIXF3mlSnkDeRIzHm4M59rhn
dmwv7y81mF6LSKxy2mwuFiAtERViCwFXzX/GoFSVcZiJLJsLNzopXCWH1wWo7BOi
5P29arv8k1KFTqDffswLIrOulu7+9f5zIFZQucLd7E4sY8LJVZGaMtXepTv1jGkR
we2n2X0C5QPVszsoNV02V36YjMsMLXQGR9/uLyYo5o/Q6UyPkYIy6Cmtaz/opW3T
zTNzh+mkTaPucPCxI7G7bBXWmeM+OrwGJ1NGNl4FxkxXtx1j9UDt7FJC0KLGJtNW
ZD4uTP1Z0XC6YheKjGaBrpzoh3fgQbfvzt3C2s7m7GhypMghA39vIkzn9Sw+Xzs=
=5mdR
-----END PGP SIGNATURE-----

--f0KYrhQ4vYSV2aJu--


--===============0323670812==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0323670812==--
