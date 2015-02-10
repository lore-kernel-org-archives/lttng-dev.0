From: Jonathan Rajotte Julien <Jonathan.rajotte-julien@efficios.com>
Subject: Re: Google Summer of Code 2015
Date: Tue, 10 Feb 2015 14:16:10 -0500
Message-ID: <54DA58FA.8090809__40076.1939971291$1423595867$gmane$org@efficios.com>
References: <CA+jJMxsJ1q5KbUMRfQ_PzmP+BGYFikBvnJ0MTndOFH65KpFXsA@mail.gmail.com>
 <54DA32A3.6050500@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Jonathan.rajotte-julien@efficios.com>)
 id 1YLGIF-00080x-36
 for lttng-dev@lists.lttng.org; Tue, 10 Feb 2015 14:16:27 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 8F95E3400E1
 for <lttng-dev@lists.lttng.org>; Tue, 10 Feb 2015 19:16:21 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id FK8r9xhS3qHA for <lttng-dev@lists.lttng.org>;
 Tue, 10 Feb 2015 19:16:21 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 1B8E3340232
 for <lttng-dev@lists.lttng.org>; Tue, 10 Feb 2015 19:16:21 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id EerecQkk2GpC for <lttng-dev@lists.lttng.org>;
 Tue, 10 Feb 2015 19:16:21 +0000 (UTC)
Received: from [172.16.0.150] (cable-22.246.173-116.electronicbox.net
 [173.246.22.116])
 by mail.efficios.com (Postfix) with ESMTPSA id AD5C33400E1
 for <lttng-dev@lists.lttng.org>; Tue, 10 Feb 2015 19:16:20 +0000 (UTC)
In-Reply-To: <54DA32A3.6050500@ericsson.com>
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

Hey Matthew,

This would be very nice indeed. But it might probably be done sooner =

than you think ;). We are currently revamping our CI and we will =

certainly need a way to easily deploy&test on multiple distro/kernel =

(regression and stress test). This work will be a good start and I'll =

make sure we provide ready to deploy VM/script to the community.

Thanks!

On 15-02-10 11:32 AM, Matthew Khouzam wrote:
> Here is something I wanted for a while:
>
> VMs for every Major release of LTTng
>
> The vm would have:
>
> * an up to date-ish kernel, let's say 3.0+ :)
> * lttng kernel modules
> * lttng userspace libs
> * No X
> * ssh server configured with a user in the tracing group
> * a simple program running that has two looping threads that sleep for
> say .5 and .3 seconds each, then record an event.
>
> This would make regression testing much easier, I don't know if it's
> sexy enough though, it has vms I guess.
>
> PS. great to see SOC is working out for you guys!
>
>
> On 15-02-09 03:43 PM, J=E9r=E9mie Galarneau wrote:
>> Hi everyone,
>>
>> We are planning to take part in Google Summer of Code as a mentoring
>> organization for a third year!
>>
>> Now is your chance to share your feature wishlist. We are looking for
>> project ideas you think a student, presumably unfamiliar with the
>> project, could undertake in three months. Anything goes!
>>
>> Keep in mind the application deadline is February 20th.
>>
>> Some past project ideas for inspiration:
>> http://bugs.lttng.org/projects/lttng/wiki/Google_Summer_of_Code_2014
>> http://bugs.lttng.org/projects/lttng/wiki/Google_Summer_of_Code_2013
>>
>> Thanks,
>> J=E9r=E9mie
>>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- =

Jonathan R. Julien
Efficios
