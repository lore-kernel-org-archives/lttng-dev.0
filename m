From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Extract lttng trace from kernel coredump
Date: Tue, 18 Feb 2014 21:59:32 +0000 (UTC)
Message-ID: <2133531474.27181.1392760772248.JavaMail.zimbra__38267.9482725964$1392760841$gmane$org@efficios.com>
References: <52D46B33.4010401@acm.org> <52D5A08F.4020204@acm.org>
	<1303248645.9400.1390063653581.JavaMail.zimbra@efficios.com>
	<52DAC820.7000005@acm.org>
	<353610105.9520.1390071650232.JavaMail.zimbra@efficios.com>
	<5303B493.7080200@acm.org>
	<271092494.27125.1392757335976.JavaMail.zimbra@efficios.com>
	<801064989.27153.1392759726541.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_27179_510204892.1392760772245"
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1WFshS-0000aj-QS
	for lttng-dev@lists.lttng.org; Tue, 18 Feb 2014 16:59:41 -0500
In-Reply-To: <801064989.27153.1392759726541.JavaMail.zimbra@efficios.com>
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

------=_Part_27179_510204892.1392760772245
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- Original Message -----
> From: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> To: minyard@acm.org
> Cc: lttng-dev@lists.lttng.org
> Sent: Tuesday, February 18, 2014 4:42:06 PM
> Subject: Re: [lttng-dev] Extract lttng trace from kernel coredump
> 
> ----- Original Message -----
> > From: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> > To: minyard@acm.org
> > Cc: lttng-dev@lists.lttng.org
> > Sent: Tuesday, February 18, 2014 4:02:15 PM
> > Subject: Re: [lttng-dev] Extract lttng trace from kernel coredump
> > 
> > ----- Original Message -----
> > > From: "Corey Minyard" <minyard@acm.org>
> > > To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> > > Cc: "David Goulet" <dgoulet@efficios.com>, lttng-dev@lists.lttng.org
> > > Sent: Tuesday, February 18, 2014 2:29:23 PM
> > > Subject: Re: [lttng-dev] Extract lttng trace from kernel coredump
> > > 
> > > I have attached some gdb macros for dumping LTT buffers from a kernel
> > > coredump.  I haven't done a lot of testing, though.
> > 
> > Very cool! I'll have a look when things get less busy here. I hope my
> > earlier reply helps clearing things out.
> > 
> > > 
> > > I do have one question.  I've been getting the metadata by taking a
> > > snapshot right when the trace starts and saving that to stick into the
> > > trace output from the coredump.  Is that the best way, or is there some
> > > other way I can extract it?  There doesn't seem to be a metadata channel
> > > running in snapshot mode.
> > 
> > Actually, it's better if you grab the metadata near when you grab the
> > coredump. Grabbing the metadata at the beginning of your tracing session
> > will not have the info about other modules that might be coming and going
> > while tracing is active (which might contain tracepoints).
> > 
> > You could grab the metadata from the coredump actually, this would be the
> > best approach. Looking at lttng modules 2.4 rc, you will want to look at
> > 
> >  /lttng-events.h
> > 
> > struct lttng_session {
> >   ...
> >   struct lttng_metadata_cache *metadata_cache;
> >   ...
> > };
> > 
> > Which has the metadata string:
> > 
> > struct lttng_metadata_cache {
> >         char *data;                     /* Metadata cache */
> >         unsigned int cache_alloc;       /* Metadata allocated size (bytes)
> >         */
> >         unsigned int metadata_written;  /* Number of bytes written in
> >         metadata cache */
> >         struct kref refcount;           /* Metadata cache usage */
> >         struct list_head metadata_stream;       /* Metadata stream list */
> > };
> > 
> > You simply need to dump this metadata string into a "metadata" file, add a
> > "/* CTF 1.8 */\n line at the beginning, and this will generate a "text only
> > CTF metadata", which can be read by babeltrace.
> > 
> > If you happen to core dump while the metadata cache is being resized, you
> > might
> > encounter a corrupted metadata. It should not happen frequently, but it's
> > possible.
> > We could eventually change lttng_metadata_printf() so it makes sure to
> > always
> > keep a readable metadata around (by e.g. using kcalloc rather than krealloc
> > and
> > dealing carefully with cache_alloc vs data fields updates).
> 
> Oops, I meant "kzalloc".
> 
> I'm attaching a patch that should take care of making sure it is always in
> a valid state when a core dump occurs. You should be able to safely read
> "metadata_flushed" bytes of data at any time. Whatever has been flushed
> should be parseable by Babeltrace.

Updated patch (fixing poll).

Thanks,

Mathieu

> 
> Thoughts ?
> 
> Thanks,
> 
> Mathieu
> 
> > 
> > Thoughts ?
> > 
> > Thanks,
> > 
> > Mathieu
> > 
> > --
> > Mathieu Desnoyers
> > EfficiOS Inc.
> > http://www.efficios.com
> > 
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> > 
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

------=_Part_27179_510204892.1392760772245
Content-Type: text/x-patch; name=metadata-core-dump.patch
Content-Disposition: attachment; filename=metadata-core-dump.patch
Content-Transfer-Encoding: base64

Y29tbWl0IDk0ZDE1MTcwOTZmMmJjZjAxY2RmZGNjYmZiNDAzMGRkNjJkOGJlZDQKQXV0aG9yOiBN
YXRoaWV1IERlc25veWVycyA8bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29tPgpEYXRlOiAg
IFR1ZSBGZWIgMTggMTY6MzU6MDUgMjAxNCAtMDUwMAoKICAgIEVuc3VyZSBtZXRhZGF0YSBjYW4g
YmUgZXh0cmFjdGVkIGZyb20gY29yZSBkdW1wcyBhdCBhbnkgdGltZQogICAgCiAgICBTaWduZWQt
b2ZmLWJ5OiBNYXRoaWV1IERlc25veWVycyA8bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29t
PgoKZGlmZiAtLWdpdCBhL2x0dG5nLWFiaS5jIGIvbHR0bmctYWJpLmMKaW5kZXggMjYxYTBhZC4u
YmRiNGY1NyAxMDA2NDQKLS0tIGEvbHR0bmctYWJpLmMKKysrIGIvbHR0bmctYWJpLmMKQEAgLTU0
MSw3ICs1NDEsNyBAQCB1bnNpZ25lZCBpbnQgbHR0bmdfbWV0YWRhdGFfcmluZ19idWZmZXJfcG9s
bChzdHJ1Y3QgZmlsZSAqZmlscCwKIAkJaWYgKGZpbmFsaXplZCkKIAkJCW1hc2sgfD0gUE9MTEhV
UDsKIAotCQlpZiAoc3RyZWFtLT5tZXRhZGF0YV9jYWNoZS0+bWV0YWRhdGFfd3JpdHRlbiA+CisJ
CWlmIChzdHJlYW0tPm1ldGFkYXRhX2NhY2hlLT5tZXRhZGF0YV9mbHVzaGVkID4KIAkJCQlzdHJl
YW0tPm1ldGFkYXRhX291dCkKIAkJCW1hc2sgfD0gUE9MTElOOwogCX0KZGlmZiAtLWdpdCBhL2x0
dG5nLWV2ZW50cy5jIGIvbHR0bmctZXZlbnRzLmMKaW5kZXggMDUxMmEzZi4uMGU2NzUyMCAxMDA2
NDQKLS0tIGEvbHR0bmctZXZlbnRzLmMKKysrIGIvbHR0bmctZXZlbnRzLmMKQEAgLTYwMyw3ICs2
MDMsNyBAQCBpbnQgbHR0bmdfbWV0YWRhdGFfb3V0cHV0X2NoYW5uZWwoc3RydWN0IGx0dG5nX21l
dGFkYXRhX3N0cmVhbSAqc3RyZWFtLAogCWlmIChzdHJlYW0tPm1ldGFkYXRhX2luICE9IHN0cmVh
bS0+bWV0YWRhdGFfb3V0KQogCQlyZXR1cm4gMDsKIAotCWxlbiA9IHN0cmVhbS0+bWV0YWRhdGFf
Y2FjaGUtPm1ldGFkYXRhX3dyaXR0ZW4gLQorCWxlbiA9IHN0cmVhbS0+bWV0YWRhdGFfY2FjaGUt
Pm1ldGFkYXRhX2ZsdXNoZWQgLQogCQlzdHJlYW0tPm1ldGFkYXRhX2luOwogCWlmICghbGVuKQog
CQlyZXR1cm4gMDsKQEAgLTYzMSwxNyArNjMxLDQxIEBAIGVuZDoKIAlyZXR1cm4gcmV0OwogfQog
CitzdGF0aWMKK3ZvaWQgbHR0bmdfbWV0YWRhdGFfZmx1c2goc3RydWN0IGx0dG5nX3Nlc3Npb24g
KnNlc3Npb24pCit7CisJc3RydWN0IGx0dG5nX21ldGFkYXRhX2NhY2hlICpjYWNoZSA9IHNlc3Np
b24tPm1ldGFkYXRhX2NhY2hlOworCXN0cnVjdCBsdHRuZ19tZXRhZGF0YV9zdHJlYW0gKnN0cmVh
bTsKKworCWlmIChjYWNoZS0+bWV0YWRhdGFfd3JpdHRlbiA9PSBjYWNoZS0+bWV0YWRhdGFfZmx1
c2hlZCkKKwkJcmV0dXJuOworCisJLyoKKwkgKiBBcHBlbmQgdG8gbWV0YWRhdGEgYmVmb3JlIGlu
Y3JlbWVudGluZyAibWV0YWRhdGEgZmx1c2hlZCIsCisJICogZW5zdXJpbmcgdGhhdCBjb3JlIGR1
bXBzIGFsd2F5cyByZWFkIHVwIHRvICJtZXRhZGF0YSBmbHVzaGVkIgorCSAqIGJ5dGVzIG9mIHZh
bGlkIG1ldGFkYXRhLgorCSAqLworCWJhcnJpZXIoKTsKKwljYWNoZS0+bWV0YWRhdGFfZmx1c2hl
ZCA9IGNhY2hlLT5tZXRhZGF0YV93cml0dGVuOworCisJbGlzdF9mb3JfZWFjaF9lbnRyeShzdHJl
YW0sICZjYWNoZS0+bWV0YWRhdGFfc3RyZWFtLCBsaXN0KQorCQl3YWtlX3VwX2ludGVycnVwdGli
bGUoJnN0cmVhbS0+cmVhZF93YWl0KTsKK30KKwogLyoKICAqIFdyaXRlIHRoZSBtZXRhZGF0YSB0
byB0aGUgbWV0YWRhdGEgY2FjaGUuCiAgKiBNdXN0IGJlIGNhbGxlZCB3aXRoIHNlc3Npb25zX211
dGV4IGhlbGQuCisgKiBHcm93IHRoZSBtZXRhZGF0YSBjYWNoZSB3aXRoIGFsbG9jYXRpb24sIGNv
cHksIHBvcHVsYXRpbmcgdGhlIG5ldworICogc3RydWN0dXJlLCBhbmQgdGhlbiBmcmVlIHRoZSBv
bGQgc3RydWN0dXJlLCB0byBlbnN1cmUgdGhhdCB0aGVyZSBpcworICogYWx3YXlzIGEgY29uc2lz
dGVudCBzdGF0ZSB0byBncmFiIGZyb20ga2VybmVsIGNvcmUgZHVtcC4KICAqLworc3RhdGljCiBp
bnQgbHR0bmdfbWV0YWRhdGFfcHJpbnRmKHN0cnVjdCBsdHRuZ19zZXNzaW9uICpzZXNzaW9uLAog
CQkJICBjb25zdCBjaGFyICpmbXQsIC4uLikKIHsKIAljaGFyICpzdHI7CiAJc2l6ZV90IGxlbjsK
IAl2YV9saXN0IGFwOwotCXN0cnVjdCBsdHRuZ19tZXRhZGF0YV9zdHJlYW0gKnN0cmVhbTsKIAog
CVdBUk5fT05fT05DRSghQUNDRVNTX09OQ0Uoc2Vzc2lvbi0+YWN0aXZlKSk7CiAKQEAgLTY1NCwx
OCArNjc4LDMzIEBAIGludCBsdHRuZ19tZXRhZGF0YV9wcmludGYoc3RydWN0IGx0dG5nX3Nlc3Np
b24gKnNlc3Npb24sCiAJbGVuID0gc3RybGVuKHN0cik7CiAJaWYgKHNlc3Npb24tPm1ldGFkYXRh
X2NhY2hlLT5tZXRhZGF0YV93cml0dGVuICsgbGVuID4KIAkJCXNlc3Npb24tPm1ldGFkYXRhX2Nh
Y2hlLT5jYWNoZV9hbGxvYykgewotCQljaGFyICp0bXBfY2FjaGVfcmVhbGxvYzsKLQkJdW5zaWdu
ZWQgaW50IHRtcF9jYWNoZV9hbGxvY19zaXplOwotCi0JCXRtcF9jYWNoZV9hbGxvY19zaXplID0g
bWF4X3QodW5zaWduZWQgaW50LAotCQkJCXNlc3Npb24tPm1ldGFkYXRhX2NhY2hlLT5jYWNoZV9h
bGxvYyArIGxlbiwKLQkJCQlzZXNzaW9uLT5tZXRhZGF0YV9jYWNoZS0+Y2FjaGVfYWxsb2MgPDwg
MSk7Ci0JCXRtcF9jYWNoZV9yZWFsbG9jID0ga3JlYWxsb2Moc2Vzc2lvbi0+bWV0YWRhdGFfY2Fj
aGUtPmRhdGEsCi0JCQkJdG1wX2NhY2hlX2FsbG9jX3NpemUsIEdGUF9LRVJORUwpOwotCQlpZiAo
IXRtcF9jYWNoZV9yZWFsbG9jKQorCQljaGFyICpuZXdfY2FjaGUsICpvbGRfY2FjaGU7CisJCXVu
c2lnbmVkIGludCBuZXdfY2FjaGVfYWxsb2Nfc2l6ZSwgb2xkX2NhY2hlX2FsbG9jX3NpemU7CisK
KwkJb2xkX2NhY2hlX2FsbG9jX3NpemUgPSBzZXNzaW9uLT5tZXRhZGF0YV9jYWNoZS0+Y2FjaGVf
YWxsb2M7CisJCW5ld19jYWNoZV9hbGxvY19zaXplID0gbWF4X3QodW5zaWduZWQgaW50LAorCQkJ
CW9sZF9jYWNoZV9hbGxvY19zaXplICsgbGVuLAorCQkJCW9sZF9jYWNoZV9hbGxvY19zaXplIDw8
IDEpOworCQluZXdfY2FjaGUgPSBremFsbG9jKG5ld19jYWNoZV9hbGxvY19zaXplLCBHRlBfS0VS
TkVMKTsKKwkJaWYgKCFuZXdfY2FjaGUpCiAJCQlnb3RvIGVycjsKLQkJc2Vzc2lvbi0+bWV0YWRh
dGFfY2FjaGUtPmNhY2hlX2FsbG9jID0gdG1wX2NhY2hlX2FsbG9jX3NpemU7Ci0JCXNlc3Npb24t
Pm1ldGFkYXRhX2NhY2hlLT5kYXRhID0gdG1wX2NhY2hlX3JlYWxsb2M7CisJCXNlc3Npb24tPm1l
dGFkYXRhX2NhY2hlLT5jYWNoZV9hbGxvYyA9IG5ld19jYWNoZV9hbGxvY19zaXplOworCQlvbGRf
Y2FjaGUgPSBzZXNzaW9uLT5tZXRhZGF0YV9jYWNoZS0+ZGF0YTsKKwkJbWVtY3B5KG5ld19jYWNo
ZSwgb2xkX2NhY2hlLCBvbGRfY2FjaGVfYWxsb2Nfc2l6ZSk7CisJCS8qCisJCSAqIENvcHkgdGhl
IG9sZCBjYWNoZSBpbnRvIHRoZSBuZXcgb25lIGJlZm9yZSBzdG9yaW5nCisJCSAqIHRoZSBwb2lu
dGVyIHRvIG5ldyBjYWNoZSBpbnRvICJkYXRhIiwgc28gY29yZSBkdW1wcworCQkgKiByZWFkIHZh
bGlkIG1ldGFkYXRhLgorCQkgKi8KKwkJYmFycmllcigpOworCQlzZXNzaW9uLT5tZXRhZGF0YV9j
YWNoZS0+ZGF0YSA9IG5ld19jYWNoZTsKKwkJLyoKKwkJICogU3RvcmUgImRhdGEiIGJlZm9yZSBm
cmVlaW5nIHRoZSBvbGQgY2FjaGUsIHRodXMKKwkJICogZW5zdXJpbmcga2VybmVsIGNvcmUgZHVt
cHMgYWx3YXlzIHJlYWQgdXAgdG8KKwkJICogIm1ldGFkYXRhX2ZsdXNoZWQiIGJ5dGVzIG9mIHZh
bGlkIG1ldGFkYXRhLgorCQkgKi8KKwkJYmFycmllcigpOworCQlrZnJlZShvbGRfY2FjaGUpOwog
CX0KIAltZW1jcHkoc2Vzc2lvbi0+bWV0YWRhdGFfY2FjaGUtPmRhdGEgKwogCQkJc2Vzc2lvbi0+
bWV0YWRhdGFfY2FjaGUtPm1ldGFkYXRhX3dyaXR0ZW4sCkBAIC02NzMsOSArNzEyLDYgQEAgaW50
IGx0dG5nX21ldGFkYXRhX3ByaW50ZihzdHJ1Y3QgbHR0bmdfc2Vzc2lvbiAqc2Vzc2lvbiwKIAlz
ZXNzaW9uLT5tZXRhZGF0YV9jYWNoZS0+bWV0YWRhdGFfd3JpdHRlbiArPSBsZW47CiAJa2ZyZWUo
c3RyKTsKIAotCWxpc3RfZm9yX2VhY2hfZW50cnkoc3RyZWFtLCAmc2Vzc2lvbi0+bWV0YWRhdGFf
Y2FjaGUtPm1ldGFkYXRhX3N0cmVhbSwgbGlzdCkKLQkJd2FrZV91cF9pbnRlcnJ1cHRpYmxlKCZz
dHJlYW0tPnJlYWRfd2FpdCk7Ci0KIAlyZXR1cm4gMDsKIAogZXJyOgpAQCAtOTA2LDYgKzk0Miw3
IEBAIGludCBfbHR0bmdfZXZlbnRfbWV0YWRhdGFfc3RhdGVkdW1wKHN0cnVjdCBsdHRuZ19zZXNz
aW9uICpzZXNzaW9uLAogCiAJZXZlbnQtPm1ldGFkYXRhX2R1bXBlZCA9IDE7CiBlbmQ6CisJbHR0
bmdfbWV0YWRhdGFfZmx1c2goc2Vzc2lvbik7CiAJcmV0dXJuIHJldDsKIAogfQpAQCAtOTU4LDYg
Kzk5NSw3IEBAIGludCBfbHR0bmdfY2hhbm5lbF9tZXRhZGF0YV9zdGF0ZWR1bXAoc3RydWN0IGx0
dG5nX3Nlc3Npb24gKnNlc3Npb24sCiAKIAljaGFuLT5tZXRhZGF0YV9kdW1wZWQgPSAxOwogZW5k
OgorCWx0dG5nX21ldGFkYXRhX2ZsdXNoKHNlc3Npb24pOwogCXJldHVybiByZXQ7CiB9CiAKQEAg
LTk2Nyw3ICsxMDA1LDkgQEAgZW5kOgogc3RhdGljCiBpbnQgX2x0dG5nX3N0cmVhbV9wYWNrZXRf
Y29udGV4dF9kZWNsYXJlKHN0cnVjdCBsdHRuZ19zZXNzaW9uICpzZXNzaW9uKQogewotCXJldHVy
biBsdHRuZ19tZXRhZGF0YV9wcmludGYoc2Vzc2lvbiwKKwlpbnQgcmV0OworCisJcmV0ID0gbHR0
bmdfbWV0YWRhdGFfcHJpbnRmKHNlc3Npb24sCiAJCSJzdHJ1Y3QgcGFja2V0X2NvbnRleHQge1xu
IgogCQkiCXVpbnQ2NF9jbG9ja19tb25vdG9uaWNfdCB0aW1lc3RhbXBfYmVnaW47XG4iCiAJCSIJ
dWludDY0X2Nsb2NrX21vbm90b25pY190IHRpbWVzdGFtcF9lbmQ7XG4iCkBAIC05NzcsNiArMTAx
Nyw4IEBAIGludCBfbHR0bmdfc3RyZWFtX3BhY2tldF9jb250ZXh0X2RlY2xhcmUoc3RydWN0IGx0
dG5nX3Nlc3Npb24gKnNlc3Npb24pCiAJCSIJdWludDMyX3QgY3B1X2lkO1xuIgogCQkifTtcblxu
IgogCQkpOworCWx0dG5nX21ldGFkYXRhX2ZsdXNoKHNlc3Npb24pOworCXJldHVybiByZXQ7CiB9
CiAKIC8qCkBAIC05OTMsNyArMTAzNSw5IEBAIGludCBfbHR0bmdfc3RyZWFtX3BhY2tldF9jb250
ZXh0X2RlY2xhcmUoc3RydWN0IGx0dG5nX3Nlc3Npb24gKnNlc3Npb24pCiBzdGF0aWMKIGludCBf
bHR0bmdfZXZlbnRfaGVhZGVyX2RlY2xhcmUoc3RydWN0IGx0dG5nX3Nlc3Npb24gKnNlc3Npb24p
CiB7Ci0JcmV0dXJuIGx0dG5nX21ldGFkYXRhX3ByaW50ZihzZXNzaW9uLAorCWludCByZXQ7CisK
KwlyZXQgPSBsdHRuZ19tZXRhZGF0YV9wcmludGYoc2Vzc2lvbiwKIAkic3RydWN0IGV2ZW50X2hl
YWRlcl9jb21wYWN0IHtcbiIKIAkiCWVudW0gOiB1aW50NV90IHsgY29tcGFjdCA9IDAgLi4uIDMw
LCBleHRlbmRlZCA9IDMxIH0gaWQ7XG4iCiAJIgl2YXJpYW50IDxpZD4ge1xuIgpAQCAtMTAyMiw2
ICsxMDY2LDggQEAgaW50IF9sdHRuZ19ldmVudF9oZWFkZXJfZGVjbGFyZShzdHJ1Y3QgbHR0bmdf
c2Vzc2lvbiAqc2Vzc2lvbikKIAlsdHRuZ19hbGlnbm9mKHVpbnQzMl90KSAqIENIQVJfQklULAog
CWx0dG5nX2FsaWdub2YodWludDE2X3QpICogQ0hBUl9CSVQKIAkpOworCWx0dG5nX21ldGFkYXRh
X2ZsdXNoKHNlc3Npb24pOworCXJldHVybiByZXQ7CiB9CiAKICAvKgpAQCAtMTIwOSw2ICsxMjU1
LDcgQEAgc2tpcF9zZXNzaW9uOgogCX0KIAlzZXNzaW9uLT5tZXRhZGF0YV9kdW1wZWQgPSAxOwog
ZW5kOgorCWx0dG5nX21ldGFkYXRhX2ZsdXNoKHNlc3Npb24pOwogCXJldHVybiByZXQ7CiB9CiAK
ZGlmZiAtLWdpdCBhL2x0dG5nLWV2ZW50cy5oIGIvbHR0bmctZXZlbnRzLmgKaW5kZXggNmIzOTMw
NC4uOWQ0M2Q0NyAxMDA2NDQKLS0tIGEvbHR0bmctZXZlbnRzLmgKKysrIGIvbHR0bmctZXZlbnRz
LmgKQEAgLTMyNiw2ICszMjYsNyBAQCBzdHJ1Y3QgbHR0bmdfbWV0YWRhdGFfY2FjaGUgewogCWNo
YXIgKmRhdGE7CQkJLyogTWV0YWRhdGEgY2FjaGUgKi8KIAl1bnNpZ25lZCBpbnQgY2FjaGVfYWxs
b2M7CS8qIE1ldGFkYXRhIGFsbG9jYXRlZCBzaXplIChieXRlcykgKi8KIAl1bnNpZ25lZCBpbnQg
bWV0YWRhdGFfd3JpdHRlbjsJLyogTnVtYmVyIG9mIGJ5dGVzIHdyaXR0ZW4gaW4gbWV0YWRhdGEg
Y2FjaGUgKi8KKwl1bnNpZ25lZCBpbnQgbWV0YWRhdGFfZmx1c2hlZDsJLyogTnVtYmVyIG9mIGJ5
dGVzIGZsdXNoZWQgaW4gbWV0YWRhdGEgY2FjaGUgKi8KIAlzdHJ1Y3Qga3JlZiByZWZjb3VudDsJ
CS8qIE1ldGFkYXRhIGNhY2hlIHVzYWdlICovCiAJc3RydWN0IGxpc3RfaGVhZCBtZXRhZGF0YV9z
dHJlYW07CS8qIE1ldGFkYXRhIHN0cmVhbSBsaXN0ICovCiB9Owo=
------=_Part_27179_510204892.1392760772245
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

------=_Part_27179_510204892.1392760772245--
