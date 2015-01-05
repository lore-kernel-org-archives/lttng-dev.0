From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: Re: lttng module error
Date: Mon, 05 Jan 2015 15:42:44 -0500
Message-ID: <54AAF744.10503__39585.1716436029$1420490597$gmane$org@voxpopuli.im>
References: <CA+=dQ-_34nLvPf5iJ2oV2tbJNzgCZ4ma-vYwMbm=0UPnZtFp+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <alexmonthy@voxpopuli.im>) id 1Y8ETz-0005Gn-Qg
 for lttng-dev@lists.lttng.org; Mon, 05 Jan 2015 15:42:36 -0500
In-Reply-To: <CA+=dQ-_34nLvPf5iJ2oV2tbJNzgCZ4ma-vYwMbm=0UPnZtFp+A@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Divya Vyas <dvyas@mvista.com>, lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi,


On 01/05/2015 12:58 AM, Divya Vyas wrote:
> Hi,
>
> I am getting this error while building lttng-modules folder:
>
> In function =91lttng_statedump_process_ns=92:
> /home/divya/Downloads/lttng-modules-a94de96/lttng-statedump-impl.c:301:2:
> error: implicit declaration of function =91task_nsproxy=92
> [-Werror=3Dimplicit-function-declaration]
>    proxy =3D task_nsproxy(p);
>    ^
> /home/divya/Downloads/lttng-modules-a94de96/lttng-statedump-impl.c:301:8:
> warning: assignment makes pointer from integer without a cast [enabled by
> default]
>    proxy =3D task_nsproxy(p);
>          ^

I experienced this issue with a distro kernel that had backported =

patches that changed some internal APIs. That kernel was still =

advertizing the same version number, so lttng-modules ended up using the =

wrong code path.

See http://bugs.lttng.org/issues/838

I'm not sure about your other compilation error though, I don't remember =

seeing that one. But it may be due to the same reason.


HTH,
Alex

> /home/divya/Downloads/lttng-modules-a94de96/lttng-statedump-impl.c: In
> function =91do_lttng_statedump=92:
> /home/divya/Downloads/lttng-modules-a94de96/lttng-statedump-impl.c:395:2:
> error: implicit declaration of function =91lttng_list_interrupts=92
> [-Werror=3Dimplicit-function-declaration]
>    lttng_list_interrupts(session);
>
> Has anybody faced this issue?
>
