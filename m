From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: [RFC] Dynamic instrumentation support in UST
Date: Tue, 30 Jul 2013 13:37:03 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD1BE24CEF__2029.50230236656$1375191506$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
References: <48CF5AC71E61DB46B70D0F388054EFFD1BE24A83@VAL-E-02.valcartier.drdc-rddc.gc.ca>
	<CAJ7wx-Hue-Y=Xm1TEtp7YfYfzVVGJgz0OE0iXXMvxhehwJ3bBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1V4A79-0003qx-HZ
	for lttng-dev@lists.lttng.org; Tue, 30 Jul 2013 09:37:35 -0400
In-Reply-To: <CAJ7wx-Hue-Y=Xm1TEtp7YfYfzVVGJgz0OE0iXXMvxhehwJ3bBw@mail.gmail.com>
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Zifei Tong <soariez@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

-----Message d'origine-----
Envoy=E9=A0: 30 juillet 2013 09:26

> If we use the command line interface you described, like
>      lttng enable-event --processname a.out
> Then we will need a mechanism to distinguish processes with the same name=
. For example, I want to instrument my program for debugging but not touch =
any processes in production.

   That's an odd use case you're describing.  If one wanted to trace specif=
ic process instances, one would naturally use PIDs instead of process names=
.  (Maybe the PID command option could accept enumerations of PIDs, i.e. so=
mething like 'lttng whatever --pid=3D{123, 456, 789}')  If one did not know=
 the PIDs in advance (hence the reliance on process names), then the soluti=
on would be to use filters on the events, no?  Your to-be-debugged program =
could be run with an environment (or internal global variable) setting that=
 the filters could check, for instance.

   In the near future, one could use namespaces to isolate the production i=
nstances from the experimental ones.

Daniel U. Thibault
Protection des syst=E8mes et contremesures (PSC) | Systems Protection & Cou=
ntermeasures (SPC)
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =
Cyber Security (MCCS)
R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence R&D=
 Canada - Valcartier (DRDC Valcartier)
2459 route de la Bravoure
Qu=E9bec QC  G3J 1X5
CANADA
Vox : (418) 844-4000 x4245
Fax : (418) 844-4538
NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada | Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
