From: Hannes Weisbach <hannes.weisbach@mailbox.tu-dresden.de>
Subject: Re: [BUG] lttng-sessiond
Date: Sat, 25 Apr 2015 16:37:17 +0200
Message-ID: <9E6E6DE2-E219-4F79-9687-BE7A45910C34__15287.1594219052$1430001662$gmane$org@mailbox.tu-dresden.de>
References: <3E06425C-5C41-4BF7-8156-A62C4E9B5E60@mailbox.tu-dresden.de>
 <1230298824.35208.1429817200877.JavaMail.zimbra@efficios.com>
 <1795330554.35257.1429820009277.JavaMail.zimbra@efficios.com>
 <DE838679-50E7-464E-B47B-934EF31813A9@mailbox.tu-dresden.de>
 <480136718.35882.1429900335415.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: multipart/mixed; boundary="===============1844570074=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mailout1.zih.tu-dresden.de ([141.30.67.72])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <hannes.weisbach@mailbox.tu-dresden.de>)
 id 1Ym1Cp-0005Vr-FC
 for lttng-dev@lists.lttng.org; Sat, 25 Apr 2015 10:37:20 -0400
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


--===============1844570074==
Content-Type: multipart/signed; boundary="Apple-Mail=_13AD7A8F-22F0-4FAD-9BEA-82491D4D65D4"; protocol="application/pgp-signature"; micalg=pgp-sha1


--Apple-Mail=_13AD7A8F-22F0-4FAD-9BEA-82491D4D65D4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

>=20
> Why do you need to load those explicitly ? They should be
> already loaded by default. I don't get those errors here.
> Which shell are you using (sh symlink) ? Can you reproduce
> using bash ?
Ok.  Found the bug.  In append_list_to_probes() index is used to get
the current index into the probes array.  However in the loop, index
is never incremented.  Therefore, the first entry of probes is
overwritten, but nr_probes is incremented, and later those "empty"
entries are referenced.

There is also a memory leak in append_list_to_probes():
=20
tmp_list =3D strdup(list); // uses malloc()
next =3D strtok(tmp_list, ","); // tmp_list needs to be NULL except in =
the first iteration
tmp_list =3D NULL; // so set it NULL
free(tmp_list); // good intention, does not work.

Best regards,
Hannes

--Apple-Mail=_13AD7A8F-22F0-4FAD-9BEA-82491D4D65D4
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iEYEARECAAYFAlU7pp0ACgkQ74te23KpN+mYGACeIri0+oHjExDskTkNmz5nZz1U
RykAn0J7o/p3lgZDKgVh0ai7yVqbaeQ6
=5o7x
-----END PGP SIGNATURE-----

--Apple-Mail=_13AD7A8F-22F0-4FAD-9BEA-82491D4D65D4--


--===============1844570074==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1844570074==--
