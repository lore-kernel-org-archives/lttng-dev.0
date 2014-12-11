From: Yan Grange <ygrange@gmail.com>
Subject: Re: Errors compiling converted tp file
Date: Thu, 11 Dec 2014 14:56:26 +0100
Message-ID: <9F3E07F7-AA26-49A3-BE48-E117868890E2__2172.80302099443$1418310373$gmane$org@gmail.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD6FBE18D6@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <ygrange@gmail.com>) id 1Xz4EM-0001Go-PJ
 for lttng-dev@lists.lttng.org; Thu, 11 Dec 2014 08:56:39 -0500
Received: by mail-wg0-f51.google.com with SMTP id x12so6379796wgg.24
 for <lttng-dev@lists.lttng.org>; Thu, 11 Dec 2014 05:56:29 -0800 (PST)
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD6FBE18D6@VAL-E-02.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi,

I can't really make out 
> 
>> However it actually works to create a header file from a tp file and compile (and run) the code. However I now get in trouble when executing:
>> 
>> $ lttng list --userspace
>> Error: Unable to list UST events: Undefined command
>> Error: Command error
>> 
>> So I guess something still went somewhat wrong but I can't really see what.
>> 
>> Yan Grange
> 
>   In order to trace user-space, you must install, in sequence, the following packages: userspace-rcu, lttng-ust, lttng-tools.  Was this done?
> 
I tried to install the right packages but there don't seem to be packages named like that in either the ubuntu repository or the ppa provided by you.

I have the following packages installed:
lttng-tools
liblttng-ust0
liblttng-ust-dev
liblttng-ust-ctl2
liblttng-ctl0
liburcu-dev
liburcu2

With all this installed, I still don't get it to work.

Cheers

Yan Grange 
