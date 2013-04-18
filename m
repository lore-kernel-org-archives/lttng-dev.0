From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: Help needed in getting first ust event running (was
 Re: lttng-dev Digest, Vol 60, Issue 31)
Date: Thu, 18 Apr 2013 20:27:38 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD12D0EF0F__20924.3020079613$1366316940$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1USvRe-0006wt-P1
	for lttng-dev@lists.lttng.org; Thu, 18 Apr 2013 16:28:38 -0400
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

> The kernel modules are indeed not needed for userspace tracing.
>
> I'm guessing you installed from source since the lttng libs don't seem
> present in your path. Could tell us on which revision this is
> happening?
>
> Also, perhaps you could try Mathieu's recently commited fix? It may be re=
lated.[1]
> [1] http://lists.lttng.org/pipermail/lttng-dev/2013-April/020064.html

   Yup, it was the same problem.  I've just rebuilt using the latest usersp=
ace-ust and lttng-ust, and the user-space-only trace was generated without =
a hitch on a system without lttng-modules.  I've checked both the static an=
d dynamic easy-ust samples.

Daniel U. Thibault
R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) / Defence R&D=
 Canada - Valcartier (DRDC Valcartier)
Cyber s=E9curit=E9 pour les missions essentielles (CME) / Mission Critical =
Cyber Security (MCCS)
Protection des syst=E8mes et contremesures (PSC) / Systems Protection & Cou=
ntermeasures (SPC)
2459 route de la Bravoure
Qu=E9bec, QC  G3J 1X5
CANADA
Vox : (418) 844-4000 x4245
Fax : (418) 844-4538
NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada / Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
