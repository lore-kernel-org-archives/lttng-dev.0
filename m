From: Christian Babeux <christian.babeux@efficios.com>
Subject: Re: snapshot issue in lttng 2.3.0
Date: Wed, 25 Sep 2013 10:28:21 -0400
Message-ID: <CAGDH53m0F3DTUo0vjkJu7m2NtqF_Xa1hcVuO6c9gR8rqECDCxQ__19075.1132708558$1380119370$gmane$org@mail.gmail.com>
References: <1380055364.86398.YahooMailBasic@web163905.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ve0-f170.google.com ([209.85.128.170])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1VOq4p-0000hK-Bq
	for lttng-dev@lists.lttng.org; Wed, 25 Sep 2013 10:28:32 -0400
Received: by mail-ve0-f170.google.com with SMTP id c14so4743808vea.15
	for <lttng-dev@lists.lttng.org>; Wed, 25 Sep 2013 07:28:21 -0700 (PDT)
In-Reply-To: <1380055364.86398.YahooMailBasic@web163905.mail.gq1.yahoo.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Thuya Aung <thuyaaung2002@yahoo.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Thuya,

> I got the error message saying "Undefined command" with the following
>
> lttng add-output -n myNewOutput file:///home/taung/output (<--- following the examples of man 1 lttng)

There was an error in the man page, the command should be "lttng
snapshot add-output". I've just sent a patch to fix this.

Also you don't need to use add-output/del-output if you want to change
to default snapshot output location. It can be specified with the
create session command and -U option:

lttng create mySession --snapshot -U file:///home/taung/output

[...]

lttng snapshot record -n snapshot_name

Also see doc/snapshot-howto.txt for a complete example.

Thanks,

Christian

On Tue, Sep 24, 2013 at 4:42 PM, Thuya Aung <thuyaaung2002@yahoo.com> wrote:
> Hello lttng-dev,
>
> With lttng 2.3.0 in Ubuntu 12.04 LTS, I only get the tracepoints in kernel folder with snapshot mode. I do not see anything for userspace tracepoints.
> The following is the way I setup for lttng session
>
> lttng create mySession --snapshot
>
> lttng enable-channel kCh --buffers-global --subbuf-size=1048576 -k
> lttng enable-event -a -k
>
> lttng enable-channel uCh --buffers-uid --subbuf-size=1048576 -u
> lttng enable-event -a -u
>
> sleep 1
> lttng start mySession
> sleep 60
>
> lttng snapshot record
>
>
> lttng stop mySession
> lttng destroy mySession
>
> I got the error message saying "Undefined command" with the following
>
> lttng add-output -n myNewOutput file:///home/taung/output (<--- following the examples of man 1 lttng)
>
> Did I do something wrong? What else I should be doing in order to use snapshot feature?
>
> Thanks in advance,
> Thuya Aung
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
