From: =?ISO-8859-1?Q?St=E9phane_Graber?= <stgraber@ubuntu.com>
Subject: Re: latest version of LTTng UST on Ubuntu 12.04
Date: Mon, 19 Nov 2012 12:51:19 -0500
Message-ID: <50AA7197.4080508__17755.2149551504$1353347822$gmane$org@ubuntu.com>
References: <7F632A9222059A42AF70FCB7965774AA20987947@ALA-MBB.corp.ad.wrs.com>
	<20121119151752.GB16248@Krystal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1873404405=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from vorash.stgraber.org ([176.9.111.221] helo=smtpout.stgraber.org)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <stgraber@ubuntu.com>) id 1TaVVD-0006JO-F6
	for lttng-dev@lists.lttng.org; Mon, 19 Nov 2012 12:51:23 -0500
In-Reply-To: <20121119151752.GB16248@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, "McDermott,
	Andrew" <Andrew.McDermott@windriver.com>
List-Id: lttng-dev@lists.lttng.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============1873404405==
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="------------enig987352B2EF16D33F12EAD4A0"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig987352B2EF16D33F12EAD4A0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

Sorry, I've been terribly busy lately.

Ubuntu has a pretty strict policy of only accepting bugfixes in the
-updates pocket post-release.

For LTTng, the 2.0.x series is supposed to be feature stable so should
in theory be fine to push to the -updates pocket. However for that to
happen, someone needs to grab all the lttng releases from 2.0.1 and
check and justify every changelog entry.

My plan was to spend some time doing that once babeltrace 1.0 is
released which I now see actually happened recently.

We also need to keep in mind that we can't push something to 12.04
that's more recent than what we have in 12.10 as we need to keep a
working upgrade path between 12.04 and 12.10.

So looking at the latest releases, I think we'd want:
 - lttng-tools - 2.0.4
 - lttng-modules - 2.0.5
 - lttng-ust - 2.0.5
 - liburcu - 0.7.5
 - babeltrace - 1.0.0

That'd mean the following stable release updates for Ubuntu 12.10:
 - lttng-tools 2.0.3 =3D> 2.0.4
 - lttng-modules 2.0.4 =3D> 2.0.5
 - ust 2.0.4 =3D> 2.0.5 (the package changed name between 12.04 and 12.10=
)
 - liburcu 0.7.3 =3D> 0.7.5
 - babeltrace 1.0.0~rc4 =3D> 1.0.0

And then the following stable release updates for Ubuntu 12.04 LTS:
 - lttng-tools 2.0.1 =3D> 2.0.4
 - lttng-modules 2.0.2 =3D> 2.0.5
 - lttng-ust 2.0.2 =3D> 2.0.5
 - liburcu 0.6.7 =3D> 0.7.5
 - babeltrace 1.0.0~rc1 =3D> 1.0.0

As everyone of those would be a version change, they'd all need to come
along with a detailed test plan on all 5 supported architectures (amd64,
i386, powerpc, armel, armhf) detailing how upstart (lttng) is ensuring
that no regression has happened.
The libraries will also need to be ABI compatible as rebuilding all
reverse-dependencies isn't an option post-release.

I'd expect that work, assuming lttng upstream's current test plans are
accepted by the Ubuntu Technical Board to be of sufficient quality to
guarantee a regression-free update, to take a good dozen of hours to
prepare followed by reactive work for the month following to get those
into the updates pocket.

I don't think I'll realistically have the time to do that work anytime
soon as lttng isn't a package officially supported by Canonical and so
doesn't fall in my day job activities.

An alternative would be to get lttng into the backports pocket of Ubuntu
12.04, the process for that is quite a bit easier as it doesn't required
Technical Board approval or the strict testing process but will be less
visible to the users as they'll have to explicitly pull it from the
backports pocket (by using apt-get install lttng-tools=3D2.0.4 for exampl=
e).

Hope this clarifies the current situation a little.

On 11/19/2012 10:17 AM, Mathieu Desnoyers wrote:
> Let's ask St=E9phane Graber, our Ubuntu packager.
>=20
> Thanks,
>=20
> Mathieu
>=20
> * McDermott, Andrew (Andrew.McDermott@windriver.com) wrote:
>>
>> How often are the LTTng UST packages for Ubuntu updated?
>>
>> Having done a fresh install I see the version reported as:
>>
>>   $ lttng version
>>   lttng version 2.0.1 - Annedd'ale
>>
>> but looking at the git repo I see there is v2.0.4 tag.  Are these
>> updates only available if built from source?  In general I was trying =
to
>> avoid the daily development versions from:
>>
>>   https://launchpad.net/~lttng/+archive/daily.
>>
>> --=20
>> andy



--=20
St=E9phane Graber
Ubuntu developer
http://www.ubuntu.com


--------------enig987352B2EF16D33F12EAD4A0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBCgAGBQJQqnGXAAoJEMY4l01keS1niAgQAL5R4kQcBCfPDrGSf80pwMIm
HwZA0gZ/dWONVB0VS5wzCmBpBgvOD4NShxl7fLr5wG1HUpAWqNiGO7+NC1jLkFOu
DMcZSk1J+InuZpgbpcuB3ccyLGCjZMs6y6NY6Xvv7t1MPT6cvqRvO6XwU0ERYfep
y8JxJGaoVtPp2siVCeE3aVS8F09kUP0aWTzOF1S14mZ+SfRnKvrd2FKJGWXGV6Mj
ak0gggXEfcHIdBqHqbiPkD0fSeLoV/m7pxfFxpmQkIsM8gdHk2UfRsrZoSMvdZSM
SY2xirIY5kB0IJ1+zPHSasYB2lkdRSd7pmIoYVOf8UtschMUdpOdVXf8DXqOQJ44
CGG5b2GkaNDVJPbVBjsMxp218gvd34JmbxrM8oO/ILFHd+HJXTRMKQZLc3tPz3lb
MZuaXnXXoZskR965o8MuIJqqnUvGWaY9VH3v5SYlIjfFa5m4U9E1c/VQqNojC+E+
5LHzZLr7K0ShSlRJhDOpSAwh30c/t9+3ilOzLRUh8XzmcZtF7mCBIA+0u8k8PZUJ
5qNlHWBx26UFRR1W4mk1Roj+jEUgtLsaDgPBQcIXvWKmJG+C1/sRsGGodGX2C8h9
Th7am7so8AYL1zGoylZmCiLgz71SJSB+oY5+8aJuKUM4JlLBcj8ysPYiOIZk04lN
wQo64TUubBK34EH3b8c/
=Fx//
-----END PGP SIGNATURE-----

--------------enig987352B2EF16D33F12EAD4A0--


--===============1873404405==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1873404405==--
