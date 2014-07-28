From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Change wfq usages for wfcq
Date: Mon, 28 Jul 2014 15:32:33 -0400
Message-ID: <20140728193233.GG5591__14000.1359316104$1406576019$gmane$org@thessa>
References: <1406352416-11364-1-git-send-email-simon.marchi@polymtl.ca>
 <20140728185019.GF5591@thessa>
 <CAFXXi0m61TdHb5+EC8=kR6yrby5Bw6Sf4UeeZz0WUK37JpsM8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0079491199=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1XBqf3-0005y3-4Q
 for lttng-dev@lists.lttng.org; Mon, 28 Jul 2014 15:32:46 -0400
In-Reply-To: <CAFXXi0m61TdHb5+EC8=kR6yrby5Bw6Sf4UeeZz0WUK37JpsM8g@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Simon Marchi <simon.marchi@polymtl.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org


--===============0079491199==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8bBEDOJVaa9YlTAt"
Content-Disposition: inline


--8bBEDOJVaa9YlTAt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

As agreed on #lttng, I've merged that patch and changed the requirements
for userspace RCU from >=3D 0.7.2 to >=3D 0.8.0.

Thanks!
David

On 28 Jul (15:10:44), Simon Marchi wrote:
> On 28 July 2014 14:50, David Goulet <dgoulet@efficios.com> wrote:
> > So there is quite an issue with that which is that tools does not work
> > with urcu 0.7 anymore.
> >
> > That would mean urcu 0.8 and later would be the requirement from now on.
>=20
> Ok, so the version number of urcu in configure.ac should be updated too.
>=20
> > Not sure I'm comfortable with that but again I don't see why we should
> > not do that also....
>=20
> tools is using a deprecated API, so you'll have to do it at some
> point. I don't think it's an inconvenience for anybody. If you decide
> to upgrade to lttng-tools/lttng-ust/lttng-modules 2.6, it's not much
> more work to upgrade urcu as well.
>=20
> > David

--8bBEDOJVaa9YlTAt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJT1qVRXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02MtYH+wS6kTJ1vSGcjsdwDuXpl47x
9Ed9zUJFIly3rIJwV3sTe6I0NiiLGQWZQyezElUki1cOh0ivfbUqx3HrZSHWacSY
uiIDV5emWTYyqEXUaOYNE3W4xLnRc/lDwHC0MQAWd2Q8lg+/I9Xfj7YPvt+IsGsk
uEJGZRK5jKUytDCc8U6LNBtDnAIu/IXFH2UHP8VTRRUJx7il7z1CdYh5E25VTqUs
0edYiRX8JBqNYYE0fqppQSL7fD8/VfZv0f/gTuas4FHCV60M/OkRdXMF1+j+IldA
pAjBw6Vl46IvZFEoJUMvVK6d9vR9htTucxF6YEiOTMZc/mF+5H7B4B2GLcI6GSI=
=wD+6
-----END PGP SIGNATURE-----

--8bBEDOJVaa9YlTAt--


--===============0079491199==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0079491199==--
