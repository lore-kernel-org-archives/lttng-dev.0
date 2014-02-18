From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Extract lttng trace from kernel coredump
Date: Tue, 18 Feb 2014 21:42:06 +0000 (UTC)
Message-ID: <801064989.27153.1392759726541.JavaMail.zimbra__40849.3007220843$1392759796$gmane$org@efficios.com>
References: <52D46B33.4010401@acm.org> <20140114184243.GC8177@thessa>
	<52D5A08F.4020204@acm.org>
	<1303248645.9400.1390063653581.JavaMail.zimbra@efficios.com>
	<52DAC820.7000005@acm.org>
	<353610105.9520.1390071650232.JavaMail.zimbra@efficios.com>
	<5303B493.7080200@acm.org>
	<271092494.27125.1392757335976.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_27151_98955529.1392759726537"
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1WFsQd-0000SB-GH
	for lttng-dev@lists.lttng.org; Tue, 18 Feb 2014 16:42:17 -0500
In-Reply-To: <271092494.27125.1392757335976.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: minyard@acm.org
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

------=_Part_27151_98955529.1392759726537
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- Original Message -----
> From: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> To: minyard@acm.org
> Cc: lttng-dev@lists.lttng.org
> Sent: Tuesday, February 18, 2014 4:02:15 PM
> Subject: Re: [lttng-dev] Extract lttng trace from kernel coredump
> 
> ----- Original Message -----
> > From: "Corey Minyard" <minyard@acm.org>
> > To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> > Cc: "David Goulet" <dgoulet@efficios.com>, lttng-dev@lists.lttng.org
> > Sent: Tuesday, February 18, 2014 2:29:23 PM
> > Subject: Re: [lttng-dev] Extract lttng trace from kernel coredump
> > 
> > I have attached some gdb macros for dumping LTT buffers from a kernel
> > coredump.  I haven't done a lot of testing, though.
> 
> Very cool! I'll have a look when things get less busy here. I hope my
> earlier reply helps clearing things out.
> 
> > 
> > I do have one question.  I've been getting the metadata by taking a
> > snapshot right when the trace starts and saving that to stick into the
> > trace output from the coredump.  Is that the best way, or is there some
> > other way I can extract it?  There doesn't seem to be a metadata channel
> > running in snapshot mode.
> 
> Actually, it's better if you grab the metadata near when you grab the
> coredump. Grabbing the metadata at the beginning of your tracing session
> will not have the info about other modules that might be coming and going
> while tracing is active (which might contain tracepoints).
> 
> You could grab the metadata from the coredump actually, this would be the
> best approach. Looking at lttng modules 2.4 rc, you will want to look at
> 
>  /lttng-events.h
> 
> struct lttng_session {
>   ...
>   struct lttng_metadata_cache *metadata_cache;
>   ...
> };
> 
> Which has the metadata string:
> 
> struct lttng_metadata_cache {
>         char *data;                     /* Metadata cache */
>         unsigned int cache_alloc;       /* Metadata allocated size (bytes) */
>         unsigned int metadata_written;  /* Number of bytes written in
>         metadata cache */
>         struct kref refcount;           /* Metadata cache usage */
>         struct list_head metadata_stream;       /* Metadata stream list */
> };
> 
> You simply need to dump this metadata string into a "metadata" file, add a
> "/* CTF 1.8 */\n line at the beginning, and this will generate a "text only
> CTF metadata", which can be read by babeltrace.
> 
> If you happen to core dump while the metadata cache is being resized, you
> might
> encounter a corrupted metadata. It should not happen frequently, but it's
> possible.
> We could eventually change lttng_metadata_printf() so it makes sure to always
> keep a readable metadata around (by e.g. using kcalloc rather than krealloc
> and
> dealing carefully with cache_alloc vs data fields updates).

Oops, I meant "kzalloc".

I'm attaching a patch that should take care of making sure it is always in
a valid state when a core dump occurs. You should be able to safely read
"metadata_flushed" bytes of data at any time. Whatever has been flushed
should be parseable by Babeltrace.

Thoughts ?

Thanks,

Mathieu

> 
> Thoughts ?
> 
> Thanks,
> 
> Mathieu
> 
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

------=_Part_27151_98955529.1392759726537
Content-Type: text/x-patch; name=metadata-core-dump.patch
Content-Disposition: attachment; filename=metadata-core-dump.patch
Content-Transfer-Encoding: base64

Y29tbWl0IDg3NWZiYmJlNjE2N2IzODQ3Y2RmNGRlOTI1NzIyYmU5ZGNmNjg1Y2MKQXV0aG9yOiBN
YXRoaWV1IERlc25veWVycyA8bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29tPgpEYXRlOiAg
IFR1ZSBGZWIgMTggMTY6MzU6MDUgMjAxNCAtMDUwMAoKICAgIEVuc3VyZSBtZXRhZGF0YSBjYW4g
YmUgZXh0cmFjdGVkIGZyb20gY29yZSBkdW1wcyBhdCBhbnkgdGltZQogICAgCiAgICBTaWduZWQt
b2ZmLWJ5OiBNYXRoaWV1IERlc25veWVycyA8bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29t
PgoKZGlmZiAtLWdpdCBhL2x0dG5nLWV2ZW50cy5jIGIvbHR0bmctZXZlbnRzLmMKaW5kZXggMDUx
MmEzZi4uMGU2NzUyMCAxMDA2NDQKLS0tIGEvbHR0bmctZXZlbnRzLmMKKysrIGIvbHR0bmctZXZl
bnRzLmMKQEAgLTYwMyw3ICs2MDMsNyBAQCBpbnQgbHR0bmdfbWV0YWRhdGFfb3V0cHV0X2NoYW5u
ZWwoc3RydWN0IGx0dG5nX21ldGFkYXRhX3N0cmVhbSAqc3RyZWFtLAogCWlmIChzdHJlYW0tPm1l
dGFkYXRhX2luICE9IHN0cmVhbS0+bWV0YWRhdGFfb3V0KQogCQlyZXR1cm4gMDsKIAotCWxlbiA9
IHN0cmVhbS0+bWV0YWRhdGFfY2FjaGUtPm1ldGFkYXRhX3dyaXR0ZW4gLQorCWxlbiA9IHN0cmVh
bS0+bWV0YWRhdGFfY2FjaGUtPm1ldGFkYXRhX2ZsdXNoZWQgLQogCQlzdHJlYW0tPm1ldGFkYXRh
X2luOwogCWlmICghbGVuKQogCQlyZXR1cm4gMDsKQEAgLTYzMSwxNyArNjMxLDQxIEBAIGVuZDoK
IAlyZXR1cm4gcmV0OwogfQogCitzdGF0aWMKK3ZvaWQgbHR0bmdfbWV0YWRhdGFfZmx1c2goc3Ry
dWN0IGx0dG5nX3Nlc3Npb24gKnNlc3Npb24pCit7CisJc3RydWN0IGx0dG5nX21ldGFkYXRhX2Nh
Y2hlICpjYWNoZSA9IHNlc3Npb24tPm1ldGFkYXRhX2NhY2hlOworCXN0cnVjdCBsdHRuZ19tZXRh
ZGF0YV9zdHJlYW0gKnN0cmVhbTsKKworCWlmIChjYWNoZS0+bWV0YWRhdGFfd3JpdHRlbiA9PSBj
YWNoZS0+bWV0YWRhdGFfZmx1c2hlZCkKKwkJcmV0dXJuOworCisJLyoKKwkgKiBBcHBlbmQgdG8g
bWV0YWRhdGEgYmVmb3JlIGluY3JlbWVudGluZyAibWV0YWRhdGEgZmx1c2hlZCIsCisJICogZW5z
dXJpbmcgdGhhdCBjb3JlIGR1bXBzIGFsd2F5cyByZWFkIHVwIHRvICJtZXRhZGF0YSBmbHVzaGVk
IgorCSAqIGJ5dGVzIG9mIHZhbGlkIG1ldGFkYXRhLgorCSAqLworCWJhcnJpZXIoKTsKKwljYWNo
ZS0+bWV0YWRhdGFfZmx1c2hlZCA9IGNhY2hlLT5tZXRhZGF0YV93cml0dGVuOworCisJbGlzdF9m
b3JfZWFjaF9lbnRyeShzdHJlYW0sICZjYWNoZS0+bWV0YWRhdGFfc3RyZWFtLCBsaXN0KQorCQl3
YWtlX3VwX2ludGVycnVwdGlibGUoJnN0cmVhbS0+cmVhZF93YWl0KTsKK30KKwogLyoKICAqIFdy
aXRlIHRoZSBtZXRhZGF0YSB0byB0aGUgbWV0YWRhdGEgY2FjaGUuCiAgKiBNdXN0IGJlIGNhbGxl
ZCB3aXRoIHNlc3Npb25zX211dGV4IGhlbGQuCisgKiBHcm93IHRoZSBtZXRhZGF0YSBjYWNoZSB3
aXRoIGFsbG9jYXRpb24sIGNvcHksIHBvcHVsYXRpbmcgdGhlIG5ldworICogc3RydWN0dXJlLCBh
bmQgdGhlbiBmcmVlIHRoZSBvbGQgc3RydWN0dXJlLCB0byBlbnN1cmUgdGhhdCB0aGVyZSBpcwor
ICogYWx3YXlzIGEgY29uc2lzdGVudCBzdGF0ZSB0byBncmFiIGZyb20ga2VybmVsIGNvcmUgZHVt
cC4KICAqLworc3RhdGljCiBpbnQgbHR0bmdfbWV0YWRhdGFfcHJpbnRmKHN0cnVjdCBsdHRuZ19z
ZXNzaW9uICpzZXNzaW9uLAogCQkJICBjb25zdCBjaGFyICpmbXQsIC4uLikKIHsKIAljaGFyICpz
dHI7CiAJc2l6ZV90IGxlbjsKIAl2YV9saXN0IGFwOwotCXN0cnVjdCBsdHRuZ19tZXRhZGF0YV9z
dHJlYW0gKnN0cmVhbTsKIAogCVdBUk5fT05fT05DRSghQUNDRVNTX09OQ0Uoc2Vzc2lvbi0+YWN0
aXZlKSk7CiAKQEAgLTY1NCwxOCArNjc4LDMzIEBAIGludCBsdHRuZ19tZXRhZGF0YV9wcmludGYo
c3RydWN0IGx0dG5nX3Nlc3Npb24gKnNlc3Npb24sCiAJbGVuID0gc3RybGVuKHN0cik7CiAJaWYg
KHNlc3Npb24tPm1ldGFkYXRhX2NhY2hlLT5tZXRhZGF0YV93cml0dGVuICsgbGVuID4KIAkJCXNl
c3Npb24tPm1ldGFkYXRhX2NhY2hlLT5jYWNoZV9hbGxvYykgewotCQljaGFyICp0bXBfY2FjaGVf
cmVhbGxvYzsKLQkJdW5zaWduZWQgaW50IHRtcF9jYWNoZV9hbGxvY19zaXplOwotCi0JCXRtcF9j
YWNoZV9hbGxvY19zaXplID0gbWF4X3QodW5zaWduZWQgaW50LAotCQkJCXNlc3Npb24tPm1ldGFk
YXRhX2NhY2hlLT5jYWNoZV9hbGxvYyArIGxlbiwKLQkJCQlzZXNzaW9uLT5tZXRhZGF0YV9jYWNo
ZS0+Y2FjaGVfYWxsb2MgPDwgMSk7Ci0JCXRtcF9jYWNoZV9yZWFsbG9jID0ga3JlYWxsb2Moc2Vz
c2lvbi0+bWV0YWRhdGFfY2FjaGUtPmRhdGEsCi0JCQkJdG1wX2NhY2hlX2FsbG9jX3NpemUsIEdG
UF9LRVJORUwpOwotCQlpZiAoIXRtcF9jYWNoZV9yZWFsbG9jKQorCQljaGFyICpuZXdfY2FjaGUs
ICpvbGRfY2FjaGU7CisJCXVuc2lnbmVkIGludCBuZXdfY2FjaGVfYWxsb2Nfc2l6ZSwgb2xkX2Nh
Y2hlX2FsbG9jX3NpemU7CisKKwkJb2xkX2NhY2hlX2FsbG9jX3NpemUgPSBzZXNzaW9uLT5tZXRh
ZGF0YV9jYWNoZS0+Y2FjaGVfYWxsb2M7CisJCW5ld19jYWNoZV9hbGxvY19zaXplID0gbWF4X3Qo
dW5zaWduZWQgaW50LAorCQkJCW9sZF9jYWNoZV9hbGxvY19zaXplICsgbGVuLAorCQkJCW9sZF9j
YWNoZV9hbGxvY19zaXplIDw8IDEpOworCQluZXdfY2FjaGUgPSBremFsbG9jKG5ld19jYWNoZV9h
bGxvY19zaXplLCBHRlBfS0VSTkVMKTsKKwkJaWYgKCFuZXdfY2FjaGUpCiAJCQlnb3RvIGVycjsK
LQkJc2Vzc2lvbi0+bWV0YWRhdGFfY2FjaGUtPmNhY2hlX2FsbG9jID0gdG1wX2NhY2hlX2FsbG9j
X3NpemU7Ci0JCXNlc3Npb24tPm1ldGFkYXRhX2NhY2hlLT5kYXRhID0gdG1wX2NhY2hlX3JlYWxs
b2M7CisJCXNlc3Npb24tPm1ldGFkYXRhX2NhY2hlLT5jYWNoZV9hbGxvYyA9IG5ld19jYWNoZV9h
bGxvY19zaXplOworCQlvbGRfY2FjaGUgPSBzZXNzaW9uLT5tZXRhZGF0YV9jYWNoZS0+ZGF0YTsK
KwkJbWVtY3B5KG5ld19jYWNoZSwgb2xkX2NhY2hlLCBvbGRfY2FjaGVfYWxsb2Nfc2l6ZSk7CisJ
CS8qCisJCSAqIENvcHkgdGhlIG9sZCBjYWNoZSBpbnRvIHRoZSBuZXcgb25lIGJlZm9yZSBzdG9y
aW5nCisJCSAqIHRoZSBwb2ludGVyIHRvIG5ldyBjYWNoZSBpbnRvICJkYXRhIiwgc28gY29yZSBk
dW1wcworCQkgKiByZWFkIHZhbGlkIG1ldGFkYXRhLgorCQkgKi8KKwkJYmFycmllcigpOworCQlz
ZXNzaW9uLT5tZXRhZGF0YV9jYWNoZS0+ZGF0YSA9IG5ld19jYWNoZTsKKwkJLyoKKwkJICogU3Rv
cmUgImRhdGEiIGJlZm9yZSBmcmVlaW5nIHRoZSBvbGQgY2FjaGUsIHRodXMKKwkJICogZW5zdXJp
bmcga2VybmVsIGNvcmUgZHVtcHMgYWx3YXlzIHJlYWQgdXAgdG8KKwkJICogIm1ldGFkYXRhX2Zs
dXNoZWQiIGJ5dGVzIG9mIHZhbGlkIG1ldGFkYXRhLgorCQkgKi8KKwkJYmFycmllcigpOworCQlr
ZnJlZShvbGRfY2FjaGUpOwogCX0KIAltZW1jcHkoc2Vzc2lvbi0+bWV0YWRhdGFfY2FjaGUtPmRh
dGEgKwogCQkJc2Vzc2lvbi0+bWV0YWRhdGFfY2FjaGUtPm1ldGFkYXRhX3dyaXR0ZW4sCkBAIC02
NzMsOSArNzEyLDYgQEAgaW50IGx0dG5nX21ldGFkYXRhX3ByaW50ZihzdHJ1Y3QgbHR0bmdfc2Vz
c2lvbiAqc2Vzc2lvbiwKIAlzZXNzaW9uLT5tZXRhZGF0YV9jYWNoZS0+bWV0YWRhdGFfd3JpdHRl
biArPSBsZW47CiAJa2ZyZWUoc3RyKTsKIAotCWxpc3RfZm9yX2VhY2hfZW50cnkoc3RyZWFtLCAm
c2Vzc2lvbi0+bWV0YWRhdGFfY2FjaGUtPm1ldGFkYXRhX3N0cmVhbSwgbGlzdCkKLQkJd2FrZV91
cF9pbnRlcnJ1cHRpYmxlKCZzdHJlYW0tPnJlYWRfd2FpdCk7Ci0KIAlyZXR1cm4gMDsKIAogZXJy
OgpAQCAtOTA2LDYgKzk0Miw3IEBAIGludCBfbHR0bmdfZXZlbnRfbWV0YWRhdGFfc3RhdGVkdW1w
KHN0cnVjdCBsdHRuZ19zZXNzaW9uICpzZXNzaW9uLAogCiAJZXZlbnQtPm1ldGFkYXRhX2R1bXBl
ZCA9IDE7CiBlbmQ6CisJbHR0bmdfbWV0YWRhdGFfZmx1c2goc2Vzc2lvbik7CiAJcmV0dXJuIHJl
dDsKIAogfQpAQCAtOTU4LDYgKzk5NSw3IEBAIGludCBfbHR0bmdfY2hhbm5lbF9tZXRhZGF0YV9z
dGF0ZWR1bXAoc3RydWN0IGx0dG5nX3Nlc3Npb24gKnNlc3Npb24sCiAKIAljaGFuLT5tZXRhZGF0
YV9kdW1wZWQgPSAxOwogZW5kOgorCWx0dG5nX21ldGFkYXRhX2ZsdXNoKHNlc3Npb24pOwogCXJl
dHVybiByZXQ7CiB9CiAKQEAgLTk2Nyw3ICsxMDA1LDkgQEAgZW5kOgogc3RhdGljCiBpbnQgX2x0
dG5nX3N0cmVhbV9wYWNrZXRfY29udGV4dF9kZWNsYXJlKHN0cnVjdCBsdHRuZ19zZXNzaW9uICpz
ZXNzaW9uKQogewotCXJldHVybiBsdHRuZ19tZXRhZGF0YV9wcmludGYoc2Vzc2lvbiwKKwlpbnQg
cmV0OworCisJcmV0ID0gbHR0bmdfbWV0YWRhdGFfcHJpbnRmKHNlc3Npb24sCiAJCSJzdHJ1Y3Qg
cGFja2V0X2NvbnRleHQge1xuIgogCQkiCXVpbnQ2NF9jbG9ja19tb25vdG9uaWNfdCB0aW1lc3Rh
bXBfYmVnaW47XG4iCiAJCSIJdWludDY0X2Nsb2NrX21vbm90b25pY190IHRpbWVzdGFtcF9lbmQ7
XG4iCkBAIC05NzcsNiArMTAxNyw4IEBAIGludCBfbHR0bmdfc3RyZWFtX3BhY2tldF9jb250ZXh0
X2RlY2xhcmUoc3RydWN0IGx0dG5nX3Nlc3Npb24gKnNlc3Npb24pCiAJCSIJdWludDMyX3QgY3B1
X2lkO1xuIgogCQkifTtcblxuIgogCQkpOworCWx0dG5nX21ldGFkYXRhX2ZsdXNoKHNlc3Npb24p
OworCXJldHVybiByZXQ7CiB9CiAKIC8qCkBAIC05OTMsNyArMTAzNSw5IEBAIGludCBfbHR0bmdf
c3RyZWFtX3BhY2tldF9jb250ZXh0X2RlY2xhcmUoc3RydWN0IGx0dG5nX3Nlc3Npb24gKnNlc3Np
b24pCiBzdGF0aWMKIGludCBfbHR0bmdfZXZlbnRfaGVhZGVyX2RlY2xhcmUoc3RydWN0IGx0dG5n
X3Nlc3Npb24gKnNlc3Npb24pCiB7Ci0JcmV0dXJuIGx0dG5nX21ldGFkYXRhX3ByaW50ZihzZXNz
aW9uLAorCWludCByZXQ7CisKKwlyZXQgPSBsdHRuZ19tZXRhZGF0YV9wcmludGYoc2Vzc2lvbiwK
IAkic3RydWN0IGV2ZW50X2hlYWRlcl9jb21wYWN0IHtcbiIKIAkiCWVudW0gOiB1aW50NV90IHsg
Y29tcGFjdCA9IDAgLi4uIDMwLCBleHRlbmRlZCA9IDMxIH0gaWQ7XG4iCiAJIgl2YXJpYW50IDxp
ZD4ge1xuIgpAQCAtMTAyMiw2ICsxMDY2LDggQEAgaW50IF9sdHRuZ19ldmVudF9oZWFkZXJfZGVj
bGFyZShzdHJ1Y3QgbHR0bmdfc2Vzc2lvbiAqc2Vzc2lvbikKIAlsdHRuZ19hbGlnbm9mKHVpbnQz
Ml90KSAqIENIQVJfQklULAogCWx0dG5nX2FsaWdub2YodWludDE2X3QpICogQ0hBUl9CSVQKIAkp
OworCWx0dG5nX21ldGFkYXRhX2ZsdXNoKHNlc3Npb24pOworCXJldHVybiByZXQ7CiB9CiAKICAv
KgpAQCAtMTIwOSw2ICsxMjU1LDcgQEAgc2tpcF9zZXNzaW9uOgogCX0KIAlzZXNzaW9uLT5tZXRh
ZGF0YV9kdW1wZWQgPSAxOwogZW5kOgorCWx0dG5nX21ldGFkYXRhX2ZsdXNoKHNlc3Npb24pOwog
CXJldHVybiByZXQ7CiB9CiAKZGlmZiAtLWdpdCBhL2x0dG5nLWV2ZW50cy5oIGIvbHR0bmctZXZl
bnRzLmgKaW5kZXggNmIzOTMwNC4uOWQ0M2Q0NyAxMDA2NDQKLS0tIGEvbHR0bmctZXZlbnRzLmgK
KysrIGIvbHR0bmctZXZlbnRzLmgKQEAgLTMyNiw2ICszMjYsNyBAQCBzdHJ1Y3QgbHR0bmdfbWV0
YWRhdGFfY2FjaGUgewogCWNoYXIgKmRhdGE7CQkJLyogTWV0YWRhdGEgY2FjaGUgKi8KIAl1bnNp
Z25lZCBpbnQgY2FjaGVfYWxsb2M7CS8qIE1ldGFkYXRhIGFsbG9jYXRlZCBzaXplIChieXRlcykg
Ki8KIAl1bnNpZ25lZCBpbnQgbWV0YWRhdGFfd3JpdHRlbjsJLyogTnVtYmVyIG9mIGJ5dGVzIHdy
aXR0ZW4gaW4gbWV0YWRhdGEgY2FjaGUgKi8KKwl1bnNpZ25lZCBpbnQgbWV0YWRhdGFfZmx1c2hl
ZDsJLyogTnVtYmVyIG9mIGJ5dGVzIGZsdXNoZWQgaW4gbWV0YWRhdGEgY2FjaGUgKi8KIAlzdHJ1
Y3Qga3JlZiByZWZjb3VudDsJCS8qIE1ldGFkYXRhIGNhY2hlIHVzYWdlICovCiAJc3RydWN0IGxp
c3RfaGVhZCBtZXRhZGF0YV9zdHJlYW07CS8qIE1ldGFkYXRhIHN0cmVhbSBsaXN0ICovCiB9Owo=

------=_Part_27151_98955529.1392759726537
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

------=_Part_27151_98955529.1392759726537--
