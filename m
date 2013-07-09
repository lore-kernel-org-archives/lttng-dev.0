From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: View for virtual machine monitoring
Date: Tue, 9 Jul 2013 19:12:19 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD13423326__42618.7049983584$1373397170$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1UwdKl-0002lN-Sr
	for lttng-dev@lists.lttng.org; Tue, 09 Jul 2013 15:12:20 -0400
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
Cc: Mohamad Gebai <mohamad.gebai@polymtl.ca>
List-Id: lttng-dev@lists.lttng.org

----------------------------------------------------------------------
Date: Tue, 09 Jul 2013 14:32:54 -0400
From: Mohamad Gebai <mohamad.gebai@polymtl.ca>
To: linuxtools-dev@eclipse.org, lttng-dev@lists.lttng.org

> For the sake of our experience, we pinned vCPU0 of VM1 and vCPU0 of VM2 o=
n the same physical CPU, and ran a CPU-intensive workload for one second on=
e each one of them.
> We generated our traces using the low-overhead LTTng tracer. We can clear=
ly see that during that second, both of the virtual CPUs are fighting over =
the same physical CPU.

   You should have said "and ran a CPU-intensive workload for one second on=
 both of them simultaneously".  Otherwise you may be misconstrued as meanin=
g you ran the workloads consecutively.  (The third sentence dispels this in=
correct reading, but it's better to get the meaning across unambiguously th=
e first time)

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
