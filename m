From: Mathieu Desnoyers <mathieu.desnoyers-vg+e7yoeK/dWk0Htik3J/w@public.gmane.org>
Subject: Re: Bogus openembedded gcc patch
Date: Tue, 26 Jan 2016 19:59:49 +0000 (UTC)
Message-ID: <433937130.5072.1453838389504.JavaMail.zimbra@efficios.com>
References: <1037243108.4336.1453770172960.JavaMail.zimbra@efficios.com>
	<51287CFC-6F3C-43B1-9190-84F3B20C192E@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_5070_652604609.1453838389502"
Return-path: <openembedded-core-bounces-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org>
In-Reply-To: <51287CFC-6F3C-43B1-9190-84F3B20C192E-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/openembedded-core>,
	<mailto:openembedded-core-request-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/openembedded-core/>
List-Post: <mailto:openembedded-core-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org>
List-Help: <mailto:openembedded-core-request-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/openembedded-core>,
	<mailto:openembedded-core-request-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org?subject=subscribe>
Sender: openembedded-core-bounces-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org
Errors-To: openembedded-core-bounces-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org
To: Khem Raj <raj.khem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: lttng-dev <lttng-dev-bnB2LGs2QVJ+nrgayQ7rhA@public.gmane.org>, openembedded-core <openembedded-core-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org>
List-Id: lttng-dev@lists.lttng.org

------=_Part_5070_652604609.1453838389502
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Jan 26, 2016, at 11:28 AM, Khem Raj raj.khem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:

>> On Jan 25, 2016, at 8:02 PM, Mathieu Desnoyers <mathieu.desnoyers-vg+e7yoeK/dWk0Htik3J/w@public.gmane.org>
>> wrote:
>> 
>> Hi,
>> 
>> We are noticing the presence of the following patch in various
>> openembedded gcc versions:
>> 
>> 0024-PR-target-32219.patch
>> 
>> "From e0d15f4f8bf28c351b9215ca37f1caa24df0e1fd Mon Sep 17 00:00:00 2001
>> From: Khem Raj <raj.khem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> Date: Fri, 29 Mar 2013 09:18:54 +0400
>> Subject: [PATCH 24/35] PR target/32219
>> 
>> * varasm.c (default_binds_local_p_1): Weak data is not local.
>> 
>> Signed-off-by: Bernhard Reutner-Fischer <rep.dot.nop-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> Signed-off-by: Khem Raj <raj.khem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> 
>> Upstream-Status: Backport"
>> 
>> However, contrarily to its "Backport" status, that patch is
>> not upstream in gcc, and we're starting to wonder if this
>> would be the patch that breaks handling of start/stop automatic
>> hidden symbols we use in lttng-ust.
>> 
>> We are only experiencing problems on the various openembedded
>> compilers, but on no other distro (with same compiler versions),
>> which leads us to suspect a buggy distro-specific gcc patch.
>> 
>> We've been testing with openembedded gcc-4.9.2-r0.
>> 
>> The original gold linker issue that this patch was trying to
>> address seems to have been fixed in the gold linke since
>> then.
>> 
>> Refs:
>> http://lists.lttng.org/pipermail/lttng-dev/2014-May/023112.html
>> https://gcc.gnu.org/ml/gcc-help/2014-05/msg00042.html
>> http://cgit.openembedded.org/openembedded-core/commit/?id=3cb2b003db7371b3a47d02c08352a262e1e419b4
>> https://sourceware.org/bugzilla/show_bug.cgi?id=15435
>> 
>> Thoughts ?
> 
> OE has defaulted to gcc5 since last release, and gold issue is fixed in binutils
> 2.25
> which is what we use in 2.0 as well so it might be OK to unbolt this fix.
> Although I am not sure
> about the original problem reported in PR32219 is fixed for gcc 4.9 if we remove
> this fix.
> Have you narrowed down your issue to this patch ? if not, then it would be good
> to do so

Yes, we have narrowed down our problem to this specific patch by
removing the patch from the OE gcc patches, rebuilding gcc, and
then building our test program with that gcc. The problem goes
away when we do so, which points directly to that patch as a
culprit.

Test program is attached.

Faulty[gcc 4.9-r0 with patch 0024]:

main: myvar addr=0x600c90 __start___test=0x600c90
fct: myvar addr=0x7f8733d1eae8 __start___test=0x600c90
fct2: myvar addr=0x7f8733d1eaec __start___test=0x600c90
fct3: myvar addr=0x600c94 __start___test=0x600c90

Valid[gcc 4.9-r0 without patch 0024]:

main: myvar addr=0x600c60 __start___test=0x600c60
fct: myvar addr=0x7fb62c758a90 __start___test=0x7fb62c758a90
fct2: myvar addr=0x7fb62c758a94 __start___test=0x7fb62c758a90
fct3: myvar addr=0x600c64 __start___test=0x600c60

Thanks,

Mathieu

> 
>> 
>> Thanks,
>> 
>> Mathieu
>> 
>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
> > http://www.efficios.com

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

------=_Part_5070_652604609.1453838389502
Content-Type: application/x-compressed-tar; name=yocto-hidden-bug2.tar.gz
Content-Disposition: attachment; filename=yocto-hidden-bug2.tar.gz
Content-Transfer-Encoding: base64

H4sIAF2np1YAA+2WXW/TMBRA+1r/CtNpKJWaNB91Im0MaYiHIQ2YJiQ0AbISx1nNUqdKnEKF9t+5
aVfWNlQF1GYwfB4S59bXdu0cO9OMqcwcijjm0ozKa7ff2jk2EBBS3Z2A2Mv3BS3H9YkTuB7xnJbt
DKDYwmT3Q6lTFirMMW6xbDQu488b6237/R9lWlv/vJRWMdxlH1vXnzjz9SceIbYH6088eA2wvctB
bOI/X/+DJ/1IyH4xRGgU3nB0/pKev3pxeXp5RS9O352dWNjqK14o9NAD1eyFuv+v4TVIRMp310el
uD8YbPTfJYP7/R/OAvDfdwPtfxOEaXqE2teMYfN92jNNmZlhYUrOYx5jMxkL+KEYhnn1lOFURKMp
XByryLBjMexabHN2hqudA5tpnK5mhpAZQSayLs7evrk6wizloUSzK4wmH0HP89zlNL0F7YG6/7A4
O+5jm/+B7y3O/8AeBNX3Hwn0+d8IB0KytIw5flaoWGTW8DlaDUm1GovThMlaNVC0iiGYTAVbBssk
yAu5eDSdwPRSGiqVi6hUnFLDKDhTIpNGh9LK8k632z1GiH9VPJdLuZRWa6PovNaHT6i91s4XHt70
8EQUIhKpUFOjM3+R5w3+tL1s/KfNAZNMxDhhyqgKEFo8u+sBbxFAszkIhTS66BtqJ+McAokBM8bz
vIc7h8XR3RSFcZyfHI7X/jREPspOD6JJKRmlPdRuP50l9NZqQmftamh3d3dR8GaFnKsS5sI+Rrer
22jdf7dx/4kf/PDfqeqB/46r/W+CX/T/UYu9pvH+Rb39ez5l6v5Hjfvve/69/7Y789/X538j6PP/
t7cJ7zFtE3X/nQc4/5f89+b+20T73wT6/F//rH8cXms0Go1Go9FoNBqNRrPMd2JyaasAKAAA
------=_Part_5070_652604609.1453838389502
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
_______________________________________________
Openembedded-core mailing list
Openembedded-core-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org
http://lists.openembedded.org/mailman/listinfo/openembedded-core

------=_Part_5070_652604609.1453838389502--
