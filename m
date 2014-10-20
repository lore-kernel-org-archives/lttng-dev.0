From: Shariyar <syed.shariyar@gmail.com>
Subject: Re: Regarding CtfTmfTrace reader in TMF and LTTng's new
	trace
Date: Mon, 20 Oct 2014 14:01:17 -0400
Message-ID: <CAKQh6phk-MA-oHv3kWWU7YF--Y0-_0giqnPs4q_XKoZMpZYpbw__27610.6671001346$1413828147$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1257132035=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <syed.shariyar@gmail.com>) id 1XgHGm-0005Rz-68
 for lttng-dev@lists.lttng.org; Mon, 20 Oct 2014 14:01:30 -0400
Received: by mail-pa0-f43.google.com with SMTP id lf10so5701000pab.30
 for <lttng-dev@lists.lttng.org>; Mon, 20 Oct 2014 11:01:18 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1257132035==
Content-Type: multipart/alternative; boundary=047d7b67622e5b76ad0505de8098

--047d7b67622e5b76ad0505de8098
Content-Type: text/plain; charset=UTF-8

Hi Genevive,
I have found the sollution. Actually, I have replaced the CtfEvent and
CtfIterator by ITmfEvent and ITmfContext. This allows me to read the both
the latest and old format. The sample code is attached below, in case if
some one comes across the same problem.

Best regards,
Shariyar

>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>








































*private String fSyscall;    private CtfTmfTrace fTrace;    private
ITmfContext fCtxt;            /**     * Constructor to initialize the
trace     * @param filePath file Name     * @throws TmfTraceException An
exception during trace reading     */    public
CTFSystemCallIterator(String filePath) throws TmfTraceException {
fTrace = new CtfTmfTrace();        fTrace.initTrace(null, filePath,
CtfTmfEvent.class);        fCtxt=fTrace.seekEvent(0);
//fTraceIterator = fTrace.createIterator(); // don't use CtfIterator
}    /**     * Moves Iterator to the next event, and returns true if the
iterator     * can advance or false if the iterator cannot advance
**/    @Override    public boolean advance() {        boolean isAdvance =
true;        fSyscall = ""; //$NON-NLS-1$        ITmfEvent event;
do{        if ((event=fTrace.getNext(fCtxt))!=null){            fSyscall =
handleSysEntryEvent(event);//returns the sys call (entry) event
        }else            isAdvance=false;        } while
(fSyscall.isEmpty() && isAdvance==true);                        if
(!isAdvance)             close();                return isAdvance;    }*

--047d7b67622e5b76ad0505de8098
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdj48YnI+PC9kaXY+PGRpdj5IaSBHZW5ldml2ZSw8YnI+PC9kaXY+
PGRpdj5JIGhhdmUgZm91bmQgdGhlIHNvbGx1dGlvbi4gQWN0dWFsbHksIEkgaGF2ZSByZXBsYWNl
ZCB0aGUgQ3RmRXZlbnQgYW5kIEN0Zkl0ZXJhdG9yIGJ5IElUbWZFdmVudCBhbmQgSVRtZkNvbnRl
eHQuIFRoaXMgYWxsb3dzIG1lIHRvIHJlYWQgdGhlIGJvdGggdGhlIGxhdGVzdCBhbmQgb2xkIGZv
cm1hdC4gVGhlIHNhbXBsZSBjb2RlIGlzIGF0dGFjaGVkIGJlbG93LCBpbiBjYXNlIGlmIHNvbWUg
b25lIGNvbWVzIGFjcm9zcyB0aGUgc2FtZSBwcm9ibGVtLjxicj48YnI+PC9kaXY+PGRpdj5CZXN0
IHJlZ2FyZHMsPGJyPlNoYXJpeWFyPGJyPjwvZGl2Pjxicj48ZGl2PiZndDsmZ3Q7Jmd0OyZndDsm
Z3Q7Jmd0OyZndDsmZ3Q7Jmd0OyZndDsmZ3Q7Jmd0OyZndDsmZ3Q7Jmd0OyZndDsmZ3Q7Jmd0OyZn
dDsmZ3Q7Jmd0OyZndDsmZ3Q7Jmd0OyZndDsmZ3Q7Jmd0OyZndDsmZ3Q7Jmd0OyZndDsmZ3Q7Jmd0
OyZndDsmZ3Q7Jmd0OyZndDsmZ3Q7Jmd0OyZndDsmZ3Q7Jmd0OyZndDsmZ3Q7Jmd0OyZndDsmZ3Q7
Jmd0OyZndDsmZ3Q7Jmd0OyZndDsmZ3Q7Jmd0OyZndDsmZ3Q7Jmd0OyZndDsmZ3Q7Jmd0OyZndDsm
Z3Q7Jmd0OyZndDsmZ3Q7Jmd0OyZndDsmZ3Q7Jmd0Ozxicj7CoDxiPnByaXZhdGUgU3RyaW5nIGZT
eXNjYWxsOzxicj7CoMKgwqAgcHJpdmF0ZSBDdGZUbWZUcmFjZSBmVHJhY2U7PGJyPsKgwqDCoCBw
cml2YXRlIElUbWZDb250ZXh0IGZDdHh0O8KgwqDCoCA8YnI+wqDCoMKgIDxicj7CoMKgwqAgLyoq
PGJyPsKgwqDCoMKgICogQ29uc3RydWN0b3IgdG8gaW5pdGlhbGl6ZSB0aGUgdHJhY2U8YnI+wqDC
oMKgwqAgKiBAcGFyYW0gZmlsZVBhdGggZmlsZSBOYW1lPGJyPsKgwqDCoMKgICogQHRocm93cyBU
bWZUcmFjZUV4Y2VwdGlvbiBBbiBleGNlcHRpb24gZHVyaW5nIHRyYWNlIHJlYWRpbmc8YnI+wqDC
oMKgwqAgKi88YnI+wqDCoMKgIHB1YmxpYyBDVEZTeXN0ZW1DYWxsSXRlcmF0b3IoU3RyaW5nIGZp
bGVQYXRoKSB0aHJvd3MgVG1mVHJhY2VFeGNlcHRpb24gezxicj7CoMKgwqDCoMKgwqDCoCBmVHJh
Y2UgPSBuZXcgQ3RmVG1mVHJhY2UoKTs8YnI+wqDCoMKgwqDCoMKgwqAgZlRyYWNlLmluaXRUcmFj
ZShudWxsLCBmaWxlUGF0aCwgQ3RmVG1mRXZlbnQuY2xhc3MpOzxicj7CoMKgwqDCoMKgwqDCoCBm
Q3R4dD1mVHJhY2Uuc2Vla0V2ZW50KDApOzxicj7CoMKgwqDCoMKgwqDCoCAvL2ZUcmFjZUl0ZXJh
dG9yID0gZlRyYWNlLmNyZWF0ZUl0ZXJhdG9yKCk7IC8vIGRvbiYjMzk7dCB1c2UgQ3RmSXRlcmF0
b3I8YnI+wqDCoMKgIH08YnI+PGJyPsKgwqDCoCAvKio8YnI+wqDCoMKgwqAgKiBNb3ZlcyBJdGVy
YXRvciB0byB0aGUgbmV4dCBldmVudCwgYW5kIHJldHVybnMgdHJ1ZSBpZiB0aGUgaXRlcmF0b3I8
YnI+wqDCoMKgwqAgKiBjYW4gYWR2YW5jZSBvciBmYWxzZSBpZiB0aGUgaXRlcmF0b3IgY2Fubm90
IGFkdmFuY2U8YnI+wqDCoMKgwqAgKiovPGJyPsKgwqDCoCBAT3ZlcnJpZGU8YnI+wqDCoMKgIHB1
YmxpYyBib29sZWFuIGFkdmFuY2UoKSB7PGJyPsKgwqDCoMKgwqDCoMKgIGJvb2xlYW4gaXNBZHZh
bmNlID0gdHJ1ZTs8YnI+wqDCoMKgwqDCoMKgwqAgZlN5c2NhbGwgPSAmcXVvdDsmcXVvdDs7IC8v
JE5PTi1OTFMtMSQ8YnI+wqDCoMKgwqDCoMKgwqAgSVRtZkV2ZW50IGV2ZW50Ozxicj7CoMKgwqDC
oMKgwqDCoCBkb3s8YnI+wqDCoMKgwqDCoMKgwqAgaWYgKChldmVudD1mVHJhY2UuZ2V0TmV4dChm
Q3R4dCkpIT1udWxsKXs8YnI+wqDCoMKgwqDCoMKgwqAgwqDCoMKgIGZTeXNjYWxsID0gaGFuZGxl
U3lzRW50cnlFdmVudChldmVudCk7Ly9yZXR1cm5zIHRoZSBzeXMgY2FsbCAoZW50cnkpIGV2ZW50
IDxicj7CoMKgwqDCoMKgwqDCoCDCoMKgwqAgPGJyPsKgwqDCoMKgwqDCoMKgIH1lbHNlPGJyPsKg
wqDCoMKgwqDCoMKgIMKgwqDCoCBpc0FkdmFuY2U9ZmFsc2U7PGJyPsKgwqDCoMKgwqDCoMKgIH0g
d2hpbGUgKGZTeXNjYWxsLmlzRW1wdHkoKSAmYW1wOyZhbXA7IGlzQWR2YW5jZT09dHJ1ZSk7wqDC
oMKgIDxicj7CoMKgwqDCoMKgwqDCoCA8YnI+wqDCoMKgIDxicj7CoMKgwqDCoMKgwqDCoCBpZiAo
IWlzQWR2YW5jZSkgPGJyPsKgwqDCoMKgwqDCoMKgIMKgwqDCoCBjbG9zZSgpOzxicj7CoMKgwqDC
oMKgwqDCoCA8YnI+PGJyPsKgwqDCoMKgwqDCoMKgIHJldHVybiBpc0FkdmFuY2U7PGJyPjxicj7C
oMKgwqAgfTwvYj48YnI+PGJyPjxicj48L2Rpdj48L2Rpdj4NCg==
--047d7b67622e5b76ad0505de8098--


--===============1257132035==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1257132035==--
