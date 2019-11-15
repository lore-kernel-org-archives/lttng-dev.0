From: Simon Marchi <simark@simark.ca>
Subject: Re: Wrong "ar" used when cross-building lttng
Date: Fri, 15 Nov 2019 10:34:33 -0500
Message-ID: <50ff7646-3ca9-0fdd-f9bf-6bfa8e63bad3__25900.2562191867$1573832094$gmane$org@simark.ca>
References: <2357817.GzqeBO7jDX@devpool35> <3241563.NbJrRt7XGO@devpool35>
 <3c62ba15-bb2d-702e-86f4-90e8decc9fb1@simark.ca>
 <4096513.X5kWAsihKE@devpool35>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from simark.ca (simark.ca [158.69.221.121])
 by lists.lttng.org (Postfix) with ESMTPS id 47F2TR2kXNz1RL3
 for <lttng-dev@lists.lttng.org>; Fri, 15 Nov 2019 10:34:35 -0500 (EST)
In-Reply-To: <4096513.X5kWAsihKE@devpool35>
Content-Language: tl
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Rolf Eike Beer <eb@emlix.com>, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On 2019-11-15 3:18 a.m., Rolf Eike Beer wrote:
> Simon Marchi wrote:
>> On 2019-11-14 11:24 a.m., Rolf Eike Beer wrote:
> 
>>> I have not checked latest git, but maybe you may want to fix this warning,
>>> too?
>>>
>>> With 2.11.0 release tarball:
>>>
>>> -./configure: line 24663: test: -eq: unary operator expected
> 
>> Hmm I don't remember seeing this error, and I don't see it now.
>>
>> Could you please try with master?  If it still happens, you can try to
>> find from which line of the configure.ac or an m4 file this line comes
>> from.  I presume it won't be too hard to fix.
> 
> Sorry, my fault. If I had looked a little closer I could have given you the 
> context:
> 
>  checking for tput... /usr/bin/tput
>  tput: No value for $TERM and no -T specified
> ./configure: line 24663: test: -eq: unary operator expected
> 
> When the package is built inside our automated buildsystem these variables are 
> not set because this is no interactive shell. If I build with an interactive 
> shell these warnings are in fact not there.

It still sounds like the "test" command should be improved, it should not fail with
an invalid syntax.  Can you give us the relevant lines of configure around 24663,
and if possible match them to the source lines in configure.ac and/or one of the
m4 files in the m4 directory?

Simon
