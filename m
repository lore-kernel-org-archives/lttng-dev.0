From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: Minor documentation issue with 2.4.0
Date: Wed, 2 Apr 2014 13:16:51 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD35992CFD__723.743768367235$1396524856$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1WVL2H-0008P6-D0
 for lttng-dev@lists.lttng.org; Wed, 02 Apr 2014 09:17:02 -0400
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

----------------------------------------------------------------------
Date: Wed, 2 Apr 2014 12:23:42 +0300
From: Amit Margalit <AMITM@il.ibm.com>

> I ran a command that included an error, and noticed that 'lttng' mentions =

> -j in --buffers-pid and --buffers-uid, but nowhere else:
>
> usage: lttng enable-channel NAME[,NAME2,...] (-u | -k) [OPTIONS]
>
> Options:
> [...]
> You can see these 2 lines:
>
>      --buffers-uid        Use per UID buffer (-u/-j only)
>      --buffers-pid        Use per PID buffer (-u/-j only)
>
> But -j is not explained above.
>
> Amit Margalit

   Obviously the 2.4 man pages have yet to be fully updated.  -j is the --j=
ul (java.util.logging) domain.

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
