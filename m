From: Jonathan Rajotte Julien <Jonathan.rajotte-julien@efficios.com>
Subject: Re: 2.7.0 not support enable-event -k -a
Date: Tue, 10 Nov 2015 10:02:21 -0500
Message-ID: <564206FD.3050308__7642.91850287027$1447167803$gmane$org@efficios.com>
References: <a66fb4c0-6937-49d3-ab21-51dbf91ec4ce.zhenyu.ren@aliyun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Jonathan.rajotte-julien@efficios.com>)
 id 1ZwARL-0005x8-Cu
 for lttng-dev@lists.lttng.org; Tue, 10 Nov 2015 10:02:34 -0500
In-Reply-To: <a66fb4c0-6937-49d3-ab21-51dbf91ec4ce.zhenyu.ren@aliyun.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "zhenyu.ren" <zhenyu.ren@aliyun.com>, lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Zhenyu,

I just tested it on a Ubuntu 15.10 with kernel 4.2.3 with no problem.

Did you install from source/ppa ? Could you give us all the steps involved ?

Make sure to go over [1] to help us pinpoint the problem.

[1] https://lttng.org/community/#bug-reporting-guidelines

Cheers!

On 2015-11-10 03:17 AM, zhenyu.ren wrote:
> Hi,dev-team
>
>    I got the following erros when I run the commd 
> :lttng enable-event -k -a
> "Error: Events: Enable kernel event failed (channel channel0, session kernel_test)
> Error: Command error"
>   It seems that LTTNG-2.7.0 do NOT support enable-event option 
> "--all". Is that right?If wo ,what's the idea behind it?
>
> Thanks
> zhenyu.ren
>
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Jonathan R. Julien
Efficios
