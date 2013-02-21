From: Julien Desfossez <jdesfossez@efficios.com>
Subject: Re: Where are the live heads of lttng-tools and
	babeltrace?
Date: Thu, 21 Feb 2013 11:16:11 -0500
Message-ID: <5126484B.4010208__11508.3687509925$1361463441$gmane$org@efficios.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD01C6AA@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fukushima.klipix.org ([194.250.102.243])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1U8Yom-0004NF-Sa
	for lttng-dev@lists.lttng.org; Thu, 21 Feb 2013 11:16:21 -0500
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD01C6AA@VAL-E-01.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, "Couture,
	Mario" <Mario.Couture@drdc-rddc.gc.ca>, "Painchaud,
	Frederic" <Frederic.Painchaud@drdc-rddc.gc.ca>
List-Id: lttng-dev@lists.lttng.org

Hello Daniel,

The gitwebs for these branches are :
http://git.dorsal.polymtl.ca/~jdesfossez?p=3Dlttng-tools;a=3Dshortlog;h=3Dr=
efs/heads/lttngtop-live
http://git.dorsal.polymtl.ca/~jdesfossez?p=3Dbabeltrace;a=3Dshortlog;h=3Dre=
fs/heads/lttngtop-live

But there are no tarballs for these branches since there are no releases.

It is usually only 2 or 3 commits on top of the lttng-tools/babeltrace
commit at the last time I rebased the branches.

If you want to try this, I could also export you the tarballs somewhere,
but please keep in mind that these versions are proofs-of-concept and
nowhere near what the final implementations will look like.

The reason we use separate branches not mainlined is because for now
lttngtop-live relies on non-exported functions both from lttng-tools and
babeltrace (these functions are private for good reasons and should not
be exported as is, that is why I insist on the proof-of-concept state).

When we will start implementing the live API cleanly, the interface will
be completely different, that should happen around june.

Thanks,

Julien

On 13-02-21 10:25 AM, Thibault, Daniel wrote:
> According to http://git.dorsal.polymtl.ca/?p=3Dlttngtop.git;a=3Dshortlog;=
h=3Drefs/heads/live README (2012-Aug-30), one needs special versions of the=
 lttng-tools and babeltrace packages in order to experiment with the live l=
ttngtop alpha/beta.  For technical reasons, I can't use git: directly and u=
sually just fetch tarballs from the http: version instead.
> =

> But in this case http://git.dorsal.polymtl.ca/~jdesfossez/lttng-tools get=
s me nowhere (the browser never finishes loading the page (IE), or gives up=
 with a warning (Firefox)), http://git.dorsal.polymtl.ca has no lttng-tools=
 branch, and the http://git.lttng.org lttng-tools repository has no live he=
ad.
> =

> Likewise for babeltrace: http://git.dorsal.polymtl.ca/~jdesfossez/babeltr=
ace is unreachable, http://git.dorsal.polymtl.ca has no babeltrace branch, =
and the http://git.efficios.com babeltrace repository has no live head.
> =

> Where can the live lttngtop versions of lttng-tools and babeltrace be fou=
nd?
> =

> Daniel U. Thibault
> R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) / Defence R=
&D Canada - Valcartier (DRDC Valcartier)
> Cyber s=E9curit=E9 pour les missions essentielles (CME) / Mission Critica=
l Cyber Security (MCCS)
> Protection des syst=E8mes et contremesures (PSC) / Systems Protection & C=
ountermeasures (SPC)
> 2459 route de la Bravoure
> Qu=E9bec, QC  G3J 1X5
> CANADA
> Vox : (418) 844-4000 x4245
> Fax : (418) 844-4538
> NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
> Gouvernement du Canada / Government of Canada
> <http://www.valcartier.drdc-rddc.gc.ca/>
> =

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> =
