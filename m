From: Stefan Seefeld <stefan_seefeld@mentor.com>
Subject: Re: RFC: Fix crash in dlerror()
Date: Sat, 8 Feb 2014 11:53:44 -0500
Message-ID: <52F66118.5010003__35515.0430732921$1391878780$gmane$org@mentor.com>
References: <52F55511.2080309@mentor.com>
	<1380151240.21051.1391875592403.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090600020405020009000500"
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Stefan_Seefeld@mentor.com>) id 1WCBA8-0003SJ-J3
	for lttng-dev@lists.lttng.org; Sat, 08 Feb 2014 11:53:55 -0500
In-Reply-To: <1380151240.21051.1391875592403.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--------------090600020405020009000500
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On 02/08/2014 11:06 AM, Mathieu Desnoyers wrote:
> 
> 
> ----- Original Message -----
>> From: "Stefan Seefeld" <stefan_seefeld@mentor.com>
>> To: lttng-dev@lists.lttng.org
>> Sent: Friday, February 7, 2014 4:50:09 PM
>> Subject: [lttng-dev] RFC: Fix crash in dlerror()
>>
>> I have been looking into an issue with the malloc wrapper, where an
>> unsuccessful call to dlopen(), followed by a call to dlerror(), would
>> result in a segmentation fault when the malloc wrapper is being used.
>>
>> The problem is the following:
>>
>> The functions dlopen() and dlsym() make use of a global (though
>> thread-local) "result" structure to hold the error state, to allow a
>> subsequent call to dlerror() to report it.
>>
>> As it turns out, dlerror() itself may implicitly call realloc(), which,
>> if it hasn't been used before, triggers our wrapper to call dlsym(). So,
>> while dlerror() inspects said result structure, dlsym() re-initializes
>> it, causing the crash...
>>
>> This is arguably a bug in the dlfcn functions. The attached patch
>> attempts to fix this by moving the initialization of the realloc()
>> wrapper (i.e., the loading of the symbol) into the constructor. This
>> fixes the crash that I'm observing, but since none of these dependencies
>> are specified or documented, this change may cause other issues elsewhere.
>>
>> Are there any objections to this approach ? If not, I'll submit a formal
>> patch for this.
> 
> The issue I see with the approach you propose is if dlsym() is used
> within another constructor (from anoter lib for instance). Given that
> the order of constructor execution should be assumed to be random, we can
> run into the same error scenario you describe here.

Yes, I was worried about the same. In general there really isn't
anything we can do short of submitting a patch to glibc, as the only way
to address this correctly is to record whether we are inside a dlerror()
call. So, anything I can think of is merely heuristic.

Here is a slightly different approach: We know that the calloc symbol is
looked up very early (see the trick we use with the temporary static
calloc function to avoid the infinite recursion), and we may safely
assume that the calloc lookup won't fail (if it does, the user has more
important things to worry about). Thus, right after the calloc lookup
completed seems a good time to force the realloc lookup.

That's what this follow-up patch does (which still works for my test).

How does that look ?

	Stefan

-- 
Stefan Seefeld
CodeSourcery / Mentor Graphics
http://www.mentor.com/embedded-software/

--------------090600020405020009000500
Content-Type: text/plain; charset="UTF-8"; name="patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="patch"

ZGlmZiAtLWdpdCBhL2xpYmx0dG5nLXVzdC1saWJjLXdyYXBwZXIvbHR0bmctdXN0LW1hbGxv
Yy5jIGIvbGlibHR0bmctdXN0LWxpYmMtd3JhcHBlci9sdHRuZy11c3QtbWFsbG9jLmMKaW5k
ZXggMzNlZDE4Yi4uODQxM2YzMSAxMDA2NDQKLS0tIGEvbGlibHR0bmctdXN0LWxpYmMtd3Jh
cHBlci9sdHRuZy11c3QtbWFsbG9jLmMKKysrIGIvbGlibHR0bmctdXN0LWxpYmMtd3JhcHBl
ci9sdHRuZy11c3QtbWFsbG9jLmMKQEAgLTU0LDYgKzU0LDggQEAgc3RhdGljIHZvaWQgKnN0
YXRpY19jYWxsb2Moc2l6ZV90IG5tZW1iLCBzaXplX3Qgc2l6ZSkKIAlyZXR1cm4gJnN0YXRp
Y19jYWxsb2NfYnVmW3ByZXZfb2Zmc2V0XTsKIH0KIAorc3RhdGljIHZvaWQgKigqcGxpYmNf
cmVhbGxvYykodm9pZCAqcHRyLCBzaXplX3Qgc2l6ZSk7CisKIHZvaWQgKm1hbGxvYyhzaXpl
X3Qgc2l6ZSkKIHsKIAlzdGF0aWMgdm9pZCAqKCpwbGliY19tYWxsb2MpKHNpemVfdCBzaXpl
KTsKQEAgLTExMSw2ICsxMTMsMTYgQEAgdm9pZCAqY2FsbG9jKHNpemVfdCBubWVtYiwgc2l6
ZV90IHNpemUpCiAJCQlmcHJpbnRmKHN0ZGVyciwgImNhbGxvY3dyYXA6IHVuYWJsZSB0byBm
aW5kIGNhbGxvY1xuIik7CiAJCQlyZXR1cm4gTlVMTDsKIAkJfQorCQkvKgorCQkgKiBOb3cg
c2VlbXMgYSBnb29kIHRpbWUgdG8gYWxzbyBpbml0aWFsaXplIHRoZSByZWFsbG9jIHN5bWJv
bC4KKwkJICogKERvaW5nIHRoYXQganVzdC1pbi10aW1lIHdvbid0IHdvcmsgYXMgaXQgd291
bGQgY29ycnVwdCBzb21lCisJCSAqIGRsZmNuLWludGVybmFsIHN0YXRlLikKKwkJICovCisJ
CXBsaWJjX3JlYWxsb2MgPSBkbHN5bShSVExEX05FWFQsICJyZWFsbG9jIik7CisJCWlmIChw
bGliY19jYWxsb2MgPT0gTlVMTCkgeworCQkJZnByaW50ZihzdGRlcnIsICJjYWxsb2N3cmFw
OiB1bmFibGUgdG8gZmluZCByZWFsbG9jXG4iKTsKKwkJCXJldHVybiBOVUxMOworCQl9CiAJ
fQogCXJldHZhbCA9IHBsaWJjX2NhbGxvYyhubWVtYiwgc2l6ZSk7CiAJdHJhY2Vwb2ludCh1
c3RfbGliYywgY2FsbG9jLCBubWVtYiwgc2l6ZSwgcmV0dmFsKTsKQEAgLTExOSw3ICsxMzEs
NiBAQCB2b2lkICpjYWxsb2Moc2l6ZV90IG5tZW1iLCBzaXplX3Qgc2l6ZSkKIAogdm9pZCAq
cmVhbGxvYyh2b2lkICpwdHIsIHNpemVfdCBzaXplKQogewotCXN0YXRpYyB2b2lkICooKnBs
aWJjX3JlYWxsb2MpKHZvaWQgKnB0ciwgc2l6ZV90IHNpemUpOwogCXZvaWQgKnJldHZhbDsK
IAogCWlmIChwbGliY19yZWFsbG9jID09IE5VTEwpIHsK
--------------090600020405020009000500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--------------090600020405020009000500--
