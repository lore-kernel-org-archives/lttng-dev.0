From: Jonathan Rajotte Julien <Jonathan.rajotte-julien@efficios.com>
Subject: Re: Lttng 2.6 relayd hanged
Date: Mon, 06 Jul 2015 11:15:07 -0400
Message-ID: <559A9B7B.8080909__4974.77408866889$1436195801$gmane$org@efficios.com>
References: <CA+=ghtPz_0VPxXH+nVBbsx_j4GVCd2U+Uxfep40bTCYud1otWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Jonathan.rajotte-julien@efficios.com>)
 id 1ZC873-0007yX-Vr
 for lttng-dev@lists.lttng.org; Mon, 06 Jul 2015 11:15:26 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id D8DCE3403A6
 for <lttng-dev@lists.lttng.org>; Mon,  6 Jul 2015 15:15:13 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id L4DsA81vXr_H for <lttng-dev@lists.lttng.org>;
 Mon,  6 Jul 2015 15:15:13 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id E8F8B3403B7
 for <lttng-dev@lists.lttng.org>; Mon,  6 Jul 2015 15:15:12 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id Za33OsMf8yzp for <lttng-dev@lists.lttng.org>;
 Mon,  6 Jul 2015 15:15:12 +0000 (UTC)
Received: from [172.16.0.150] (cable-192.222.194.238.electronicbox.net
 [192.222.194.238])
 by mail.efficios.com (Postfix) with ESMTPSA id 8EAF43403A6
 for <lttng-dev@lists.lttng.org>; Mon,  6 Jul 2015 15:15:12 +0000 (UTC)
In-Reply-To: <CA+=ghtPz_0VPxXH+nVBbsx_j4GVCd2U+Uxfep40bTCYud1otWw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


Hi Kranthi,

In addition to what J=E9r=E9mie asked:

On 2015-07-03 05:32 PM, kranthi kumar wrote:
>
> Dear Sir/Madam,
>
> We are using Lttng 2.6
>

Are you building from source, git? Could you run "lttng --version" on =

all systems and paste the result.

> We are using Lttng for tracing across multiple systems.
>
> We have a relayd running on a remote-host with several system(4) with =

> 2 active sessions each, generating traces towards this remote-host.
>
> After running for 2-3 days, we observed that the tracing systems =

> restarted and the sessions are killed.
>
Is there any logs of this? If not could you retry the experiment with a =

lttng-sessiond with the  "-vvv" (verbose mode) flag set and log the =

ouptut to a file ( 2>&1 in (ba)sh ). Make sure that the newly spawned =

relayd/sessiond does not overwrite the previous log.

This option can be used on the relayd also to produce useful information.

> However we observed sockets of relayd in ESTABLISHED state. We also =

> verified that ps command showing relayd active. From =93netstat =96tanp=
=94 =

> we confirmed that relayd is listening on default port.
>
> When we tried to establish new sessions and start streaming towards =

> this relayd from our trace generating systems(all 4 one at a time) =

> again, all the systems hanged indefinitely without showing any error =

> messages.
>

Here the "-vvv" flag on any "lttng" command might show some information. =

If you are able to reproduce could you also provide us the verbose =

output of "lttng create" command and the corresponding log from =

lttng-sessiond and lttng-relayd if any.

Cheers!

> The only way to recover our trace generating systems is to restart the =

> relayd on remote host. If you restart the relayd and then create new =

> sessions, streaming can be started again.
>
> Please let us know if this is a known issue.
>
> BR
>
> Kranthi.
>
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- =

Jonathan R. Julien
Efficios
