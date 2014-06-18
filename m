From: Suchakrapani Datt Sharma <suchakrapani.sharma@polymtl.ca>
Subject: Re: Build a lttng environment on TizenIVI3.0 User-land
Date: Wed, 18 Jun 2014 13:25:01 -0400
Message-ID: <1403112301.53a1cb6db479a__5545.18212234161$1403112369$gmane$org@www.imp.polymtl.ca>
References: <53A1573B.60309@jinso.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <suchakrapani.sharma@polymtl.ca>) id 1WxJbc-0001FG-T3
 for lttng-dev@lists.lttng.org; Wed, 18 Jun 2014 13:25:10 -0400
In-Reply-To: <53A1573B.60309@jinso.co.jp>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: cm-hiep@jinso.co.jp
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Well, the kernel seems to have booted and started systemd. Its also for some
reason starting and stopping udev (and failing to start it finally). Do you
normally get these errors? It would be good to have a look at log of normal
boot and see if the errors occur after you make changes in menuconfig and a=
re
related to tracing being enabled or not.

Also, your kernel command line says the console redirection should be on tt=
ySC6.
But in the very end of log,

[ TIME ] Timed out waiting for device dev-ttySC6.device
[DEPEND] Dependency failed for Serial Getty on ttySC6.

If I am not mistaken, a .device file is supposed to be handled by udev, so I
guess that may be the cause you are not getting the login prompt.

--
Suchakra

Quoting =E3=82=AB=E3=82=AA=E3=80=80=E3=83=9F=E3=83=B3=E3=80=80=E3=83=92=E3=
=82=A7=E3=83=83=E3=83=97 <cm-hiep@jinso.co.jp>:

> Hi,
>
> I am Hiep from Jinzai Solution (A Japan company). I am working on a
> project of Tizen IVI3.0 testing.
> I'd like to build a lttng environment on Tizen IVI3.0 User-land, In
> order to fix some bugs occured
> on user space and kernel space.
> Could you please show me how to setting a lttng environment on Tizen IVI3=
.0?
>
> I have tried to build "lib-urcu=E3=80=81LTTng-usr=E3=80=81LTTng-tools=E3=
=80=81LTTng-module"
> and added them into Tizen IVI3.0
> but I could not start a kernel. there are some error logs when starting
> kernel.
>
> Here are the details of my problems:
>
> Board: Lager (Rcar-h2, chip r8a7790, Renesas board)
> User Land: Tizen IVI3.0
> Kernel: linux-ltsi-v3.4.25
>
> I attached file the ways I have built these lttng library and the error
> logs of starting kernel.
>
> Bests regards,
> Cao Minh Hiep.
>
>
