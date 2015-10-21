From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: lttng-modules-27.0-stable and CentOS 7.0
Date: Wed, 21 Oct 2015 19:04:46 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD8F9B7B74__16507.2718322792$1445454373$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1Zoygv-0006hy-B6
 for lttng-dev@lists.lttng.org; Wed, 21 Oct 2015 15:04:57 -0400
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
Date: Tue, 20 Oct 2015 14:28:31 +0000
From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
----------------------------------------------------------------------
> lttng-modules-2.7.0-stable won't compile under CentOS 7.0. Details here: =
http://bugzilla.redhat.com/show_bug.cgi?id=3D1273484
>
> Not sure if the problem is with gcc or LTTng

   Well, that turned out to be because the virtual machine was running out =
of memory during the compilation of the system call probes.  I increased it=
 from 1 GiB to 2 GiB and recompiled with no problem.

   I do get the repeated 'Can't read private key' warnings when installing =
the modules, even though lsmod says they load correctly.

Daniel U. Thibault, M.Sc.=B2

Informaticien scientifique, CME-PSC, Centre de recherches de Valcartier Rec=
herche et d?veloppement pour la d?fense Canada / Gouvernement du Canada dan=
iel.thibault@drdc-rddc.gc.ca / T?l: 418-844-4000x4245 T?l?c: 418-844-4538 d=
aniel.thibault@forces.gc.ca / T?l: 418-844-4000x4245 T?l?c: 418-844-4538

Computer Scientist, MCCS-SPC, Valcartier Research Centre Defence Research a=
nd Development Canada?/ Government of Canada daniel.thibault@drdc-rddc.gc.c=
a / Tel: 418-844-4000x4245 Fax: 418-844-4538 daniel.thibault@forces.gc.ca /=
 Tel: 418-844-4000x4245 Fax: 418-844-4538

DRDC is an agency of the Department of National Defence / RDDC est une agen=
ce du minist?re de la D?fense nationale
