From: David Goulet <dgoulet@efficios.com>
Subject: Re: Working on some bugs
Date: Tue, 11 Mar 2014 12:22:01 -0400
Message-ID: <20140311162201.GE7727__41421.5691773736$1394556655$gmane$org@thessa>
References: <CAEEAEzWcPk788kF=BptjeGsG=hrWyeK1tcUAM4Fq9GAwZYPXhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1497916856=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1WNPRS-00058x-1s
	for lttng-dev@lists.lttng.org; Tue, 11 Mar 2014 12:22:16 -0400
In-Reply-To: <CAEEAEzWcPk788kF=BptjeGsG=hrWyeK1tcUAM4Fq9GAwZYPXhQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Sandeep K Chaudhary <babbusandy2006@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


--===============1497916856==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vv4Sf/kQfcwinyKX"
Content-Disposition: inline


--vv4Sf/kQfcwinyKX
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 10 Mar (23:00:36), Sandeep K Chaudhary wrote:
> Hi guys,
>=20
> I want to submit patches for some bugs before making my GSoC application.=
 I
> was looking at the bug tracker and I think I can work some of these
> before/during the application. Can you please give some suggestion as to
> whether I will be able to work on them (given that I am new to the code
> base)?
>=20
> http://bugs.lttng.org/issues/621

This one should be quite straight forward. There is already version
check for the create_session command I think. Here is your starting
point.

lttng-tools:
* src/bin/lttng-relayd/cmd-*
* src/bin/lttng-relayd/main.c

> http://bugs.lttng.org/issues/282

That would be some work on removing tests that are not used at all in
the lttng-ust code repository and I think there is still old test using
UST 0.x but that are simply not compiled.

lttng-ust:
* tests/

> http://bugs.lttng.org/issues/204

That's a bigger one actually. You'll need to create a new command to
lttng command line (lttng status) and print some information on the
current session, maybe the state of the sessiond and relayd. The
behavior is still undefined here so maybe not the easier one to choose
:).

> http://bugs.lttng.org/issues/682

This one is babeltrace specific so I can't help you. J=E9r=E9mie or Mathieu
or Julien might be able to help you out here.

>=20
> I understand that the first three of these are marked as features, and
> could probably more than bugs but I find them interesting. Please give so=
me
> suggestions as to how I can start with some bug.

We are in the 2.5 development cycle right now so features like the one
above are actually quite welcome!

So you could do bug hunting as well meaning you use lttng, try to
bend/break it quite a bit and see if there are unexpected results. Going
through our bugtracker also with the ones flagged Bug will also work
quite well :).

Hope this help! Also, come on IRC in #lttng on OFTC network.

Cheers!
David

>=20
> Thanks,
> Sandeep.

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


--vv4Sf/kQfcwinyKX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJTHzgpXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02+foH/iHEp3vf7x2D8QyZ3n3uyI4K
AYYgA+RsQ7hwnVCEoaupKgiTgNjE5T5lzcxHScvAzSXAP9jiJzQr1miBwGID8WPz
AMCvGhlA2ubw5KylwkAHg9lAGtjKi4sLmZ/8EwnZLL85M7EOBkbx3rJ34XIvCfr3
vxwlZXLAw0Gc1sphh1u1q4tVPZxRsVUGq/jGlX/NoS+5yUXhyh/o6Oa9jAme6Yyw
N66czz06FXvU5uMFJG0y1grDMKIjALs73XNjmUda3TW801CptJi0j0dq9iG8TEjb
adrxngpDBZ18+faSMKh66q3IgTFyi/lKjDFU8GQuse8acKfXY+QMZiQ9pjarIJo=
=/wNJ
-----END PGP SIGNATURE-----

--vv4Sf/kQfcwinyKX--


--===============1497916856==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1497916856==--
