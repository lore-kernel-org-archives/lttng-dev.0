From: "D'Alessandro, Luke K" <ldalessa@indiana.edu>
Subject: Re: urcu lfht and free listing
Date: Fri, 10 Jun 2016 18:36:31 +0000
Message-ID: <36F8A95C-47D1-4D7C-AA2F-AA9B9A8B53BE__41881.6521800638$1465583821$gmane$org@indiana.edu>
References: <BF41A9C3-FD22-4AF7-80DC-C172C252B92C@indiana.edu>
 <149868690.33139.1465582936951.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2223558428970134011=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from hartman.uits.indiana.edu (belushi.uits.indiana.edu
 [129.79.1.188])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 79B98A381D
 for <lttng-dev@lists.lttng.org>; Fri, 10 Jun 2016 18:36:33 +0000 (UTC)
In-Reply-To: <149868690.33139.1465582936951.JavaMail.zimbra@efficios.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org

--===============2223558428970134011==
Content-Language: en-US
Content-Type: multipart/signed;
	boundary="Apple-Mail=_6E660831-1909-4752-B5D5-671C96130104";
	protocol="application/pgp-signature"; micalg=pgp-sha512

--Apple-Mail=_6E660831-1909-4752-B5D5-671C96130104
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On Jun 10, 2016, at 2:22 PM, Mathieu Desnoyers =
<mathieu.desnoyers@efficios.com> wrote:
>=20
> ----- On Jun 10, 2016, at 6:58 AM, D'Alessandro, Luke K =
ldalessa@indiana.edu wrote:
>=20
>> Hi List,
>>=20
>> Is it safe to free list and reuse hash table nodes (cds_lfht_node =
structures
>> used in cds_lfht_add_replace, cds_lfht_iter_get_node/cds_lfht_del) =
without
>> going through a synchronize_rcu() barrier?
>=20
> Hi,
>=20
> No, it is not safe.
>=20
> =46rom rculfhash.h:
>=20
> cds_lfht_del:
>=20
> * After successful removal, a grace period must be waited for before
> * freeing the memory reserved for old node (which can be accessed with
> * cds_lfht_iter_get_node).
>=20
> cds_lfht_add_replace:
>=20
> * After successful replacement, a grace period must be waited for =
before
> * freeing the memory reserved for the returned node.
>=20
> cds_lfht_replace:
>=20
> * After successful replacement, a grace period must be waited for =
before
> * freeing the memory reserved for the old node (which can be accessed
> * with cds_lfht_iter_get_node).

Hi Mathieu,

Thanks for the response.

I did read that documentation but it only references =E2=80=9Cfreeing=E2=80=
=9D the memory which I read as =E2=80=9Creturning the memory to the =
allocator via free()=E2=80=9D which can sometimes be an issue as it can =
cascade into an munmap that is concurrent with some reader. I wasn=E2=80=99=
t sure if simply reusing the memory was a problem.

> You can either invoke synchronize_rcu() before re-using or freeing
> the removed node, or use the call_rcu() or defer_rcu() mechanisms to
> defer reclaim after a grace period (handled by worker threads).

Great, thank you.

Thanks,

Luke

>=20
> Thanks,
>=20
> Mathieu
>=20
>>=20
>> Thanks,
>> Luke
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>=20
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com


--Apple-Mail=_6E660831-1909-4752-B5D5-671C96130104
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJXWwivAAoJEJ9t5ApCTtG0jqkQAKzQ6lduzKTk2oU1rYQGm57m
CQunn5E28m0CwL+kmqurflZaCxcSaqXljhVsr9vGeAfsJCHChRZaNQasfMvynPm2
Vlym5uAen3zQ1ZZ7+RJ/ajkBMeaqeicpc3hvsO1r2U/61hgmLzD8ayrhycRudKPH
lxOTVxxqRbxBZSWBl1HYj0YDrr2Z4E15v3eHfRgGtbWpiB/kC88l/LZYxOcp5XN2
nYiD+t9pY1HhI316U5ShPwr6qpk9E4oywZcdJHHCTMurrA3XopiBkrEmGzc5ukky
Cqy2gC+ZhX0G8ZTUkf71fwJPqZufjh3p1GkTxDtrr/BXsHhYj68lzjdi57aVnf5m
Y7JoScgmXvuDCiKberGHcqIHBgmC7DVeKjVl69T0F2AV7eUhnJ93DCwRt80+mr8u
NeGz/B5PRHqAVvTMrKN1IE//gtODoe/opNuFwMQSJQ9JAxvcE/QMYVBc1Z5ZQjOR
h8XqlfK45Ho7/KnQwUMaiPVuqZOM90O6WXSu16Md9PpAfL9kfUYo48PB8Tf4kLgB
rjOerLnXuAD+1rpVEQqFevI8gSCTcnsphojB/5PQ/skPFakryyyOmr3cGnsFF5F/
0U6q8wgxQuuEBh8BHmtLUtqPFtAqjLpVp+4fNCCoRp25HMjBiZkghZXRXQBaHrq6
V8Y4QXyODrd01VZbu8+z
=mOdM
-----END PGP SIGNATURE-----

--Apple-Mail=_6E660831-1909-4752-B5D5-671C96130104--

--===============2223558428970134011==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============2223558428970134011==--
