<!DOCTYPE html>
<html lang="en">
<head>
  <meta id="bb-bootstrap" data-current-user="{&quot;isKbdShortcutsEnabled&quot;: true, &quot;isSshEnabled&quot;: false, &quot;isAuthenticated&quot;: false}"
 />
  <meta name="bb-env" content="production" />
  
  
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta charset="utf-8">
  <title>
  Dannephoto / mlv_app_compiler 
  / source  / Mlv_App_compiler.app / Contents / main.command
 &mdash; Bitbucket
</title>
  <script nonce="" type="text/javascript">(window.NREUM||(NREUM={})).loader_config={xpid:"VwMGVVZSGwIIUFBQDwU="};window.NREUM||(NREUM={}),__nr_require=function(t,e,n){function r(n){if(!e[n]){var o=e[n]={exports:{}};t[n][0].call(o.exports,function(e){var o=t[n][1][e];return r(o||e)},o,o.exports)}return e[n].exports}if("function"==typeof __nr_require)return __nr_require;for(var o=0;o<n.length;o++)r(n[o]);return r}({1:[function(t,e,n){function r(t){try{c.console&&console.log(t)}catch(e){}}var o,i=t("ee"),a=t(20),c={};try{o=localStorage.getItem("__nr_flags").split(","),console&&"function"==typeof console.log&&(c.console=!0,o.indexOf("dev")!==-1&&(c.dev=!0),o.indexOf("nr_dev")!==-1&&(c.nrDev=!0))}catch(s){}c.nrDev&&i.on("internal-error",function(t){r(t.stack)}),c.dev&&i.on("fn-err",function(t,e,n){r(n.stack)}),c.dev&&(r("NR AGENT IN DEVELOPMENT MODE"),r("flags: "+a(c,function(t,e){return t}).join(", ")))},{}],2:[function(t,e,n){function r(t,e,n,r,c){try{h?h-=1:o(c||new UncaughtException(t,e,n),!0)}catch(f){try{i("ierr",[f,s.now(),!0])}catch(d){}}return"function"==typeof u&&u.apply(this,a(arguments))}function UncaughtException(t,e,n){this.message=t||"Uncaught error with no additional information",this.sourceURL=e,this.line=n}function o(t,e){var n=e?null:s.now();i("err",[t,n])}var i=t("handle"),a=t(21),c=t("ee"),s=t("loader"),f=t("gos"),u=window.onerror,d=!1,p="nr@seenError",h=0;s.features.err=!0,t(1),window.onerror=r;try{throw new Error}catch(l){"stack"in l&&(t(13),t(12),"addEventListener"in window&&t(6),s.xhrWrappable&&t(14),d=!0)}c.on("fn-start",function(t,e,n){d&&(h+=1)}),c.on("fn-err",function(t,e,n){d&&!n[p]&&(f(n,p,function(){return!0}),this.thrown=!0,o(n))}),c.on("fn-end",function(){d&&!this.thrown&&h>0&&(h-=1)}),c.on("internal-error",function(t){i("ierr",[t,s.now(),!0])})},{}],3:[function(t,e,n){t("loader").features.ins=!0},{}],4:[function(t,e,n){function r(){M++,S=y.hash,this[u]=b.now()}function o(){M--,y.hash!==S&&i(0,!0);var t=b.now();this[l]=~~this[l]+t-this[u],this[d]=t}function i(t,e){E.emit("newURL",[""+y,e])}function a(t,e){t.on(e,function(){this[e]=b.now()})}var c="-start",s="-end",f="-body",u="fn"+c,d="fn"+s,p="cb"+c,h="cb"+s,l="jsTime",m="fetch",v="addEventListener",w=window,y=w.location,b=t("loader");if(w[v]&&b.xhrWrappable){var g=t(10),x=t(11),E=t(8),P=t(6),O=t(13),R=t(7),T=t(14),L=t(9),j=t("ee"),N=j.get("tracer");t(15),b.features.spa=!0;var S,M=0;j.on(u,r),j.on(p,r),j.on(d,o),j.on(h,o),j.buffer([u,d,"xhr-done","xhr-resolved"]),P.buffer([u]),O.buffer(["setTimeout"+s,"clearTimeout"+c,u]),T.buffer([u,"new-xhr","send-xhr"+c]),R.buffer([m+c,m+"-done",m+f+c,m+f+s]),E.buffer(["newURL"]),g.buffer([u]),x.buffer(["propagate",p,h,"executor-err","resolve"+c]),N.buffer([u,"no-"+u]),L.buffer(["new-jsonp","cb-start","jsonp-error","jsonp-end"]),a(T,"send-xhr"+c),a(j,"xhr-resolved"),a(j,"xhr-done"),a(R,m+c),a(R,m+"-done"),a(L,"new-jsonp"),a(L,"jsonp-end"),a(L,"cb-start"),E.on("pushState-end",i),E.on("replaceState-end",i),w[v]("hashchange",i,!0),w[v]("load",i,!0),w[v]("popstate",function(){i(0,M>1)},!0)}},{}],5:[function(t,e,n){function r(t){}if(window.performance&&window.performance.timing&&window.performance.getEntriesByType){var o=t("ee"),i=t("handle"),a=t(13),c=t(12),s="learResourceTimings",f="addEventListener",u="resourcetimingbufferfull",d="bstResource",p="resource",h="-start",l="-end",m="fn"+h,v="fn"+l,w="bstTimer",y="pushState",b=t("loader");b.features.stn=!0,t(8);var g=NREUM.o.EV;o.on(m,function(t,e){var n=t[0];n instanceof g&&(this.bstStart=b.now())}),o.on(v,function(t,e){var n=t[0];n instanceof g&&i("bst",[n,e,this.bstStart,b.now()])}),a.on(m,function(t,e,n){this.bstStart=b.now(),this.bstType=n}),a.on(v,function(t,e){i(w,[e,this.bstStart,b.now(),this.bstType])}),c.on(m,function(){this.bstStart=b.now()}),c.on(v,function(t,e){i(w,[e,this.bstStart,b.now(),"requestAnimationFrame"])}),o.on(y+h,function(t){this.time=b.now(),this.startPath=location.pathname+location.hash}),o.on(y+l,function(t){i("bstHist",[location.pathname+location.hash,this.startPath,this.time])}),f in window.performance&&(window.performance["c"+s]?window.performance[f](u,function(t){i(d,[window.performance.getEntriesByType(p)]),window.performance["c"+s]()},!1):window.performance[f]("webkit"+u,function(t){i(d,[window.performance.getEntriesByType(p)]),window.performance["webkitC"+s]()},!1)),document[f]("scroll",r,{passive:!0}),document[f]("keypress",r,!1),document[f]("click",r,!1)}},{}],6:[function(t,e,n){function r(t){for(var e=t;e&&!e.hasOwnProperty(u);)e=Object.getPrototypeOf(e);e&&o(e)}function o(t){c.inPlace(t,[u,d],"-",i)}function i(t,e){return t[1]}var a=t("ee").get("events"),c=t(23)(a,!0),s=t("gos"),f=XMLHttpRequest,u="addEventListener",d="removeEventListener";e.exports=a,"getPrototypeOf"in Object?(r(document),r(window),r(f.prototype)):f.prototype.hasOwnProperty(u)&&(o(window),o(f.prototype)),a.on(u+"-start",function(t,e){var n=t[1],r=s(n,"nr@wrapped",function(){function t(){if("function"==typeof n.handleEvent)return n.handleEvent.apply(n,arguments)}var e={object:t,"function":n}[typeof n];return e?c(e,"fn-",null,e.name||"anonymous"):n});this.wrapped=t[1]=r}),a.on(d+"-start",function(t){t[1]=this.wrapped||t[1]})},{}],7:[function(t,e,n){function r(t,e,n){var r=t[e];"function"==typeof r&&(t[e]=function(){var t=r.apply(this,arguments);return o.emit(n+"start",arguments,t),t.then(function(e){return o.emit(n+"end",[null,e],t),e},function(e){throw o.emit(n+"end",[e],t),e})})}var o=t("ee").get("fetch"),i=t(20);e.exports=o;var a=window,c="fetch-",s=c+"body-",f=["arrayBuffer","blob","json","text","formData"],u=a.Request,d=a.Response,p=a.fetch,h="prototype";u&&d&&p&&(i(f,function(t,e){r(u[h],e,s),r(d[h],e,s)}),r(a,"fetch",c),o.on(c+"end",function(t,e){var n=this;e?e.clone().arrayBuffer().then(function(t){n.rxSize=t.byteLength,o.emit(c+"done",[null,e],n)}):o.emit(c+"done",[t],n)}))},{}],8:[function(t,e,n){var r=t("ee").get("history"),o=t(23)(r);e.exports=r,o.inPlace(window.history,["pushState","replaceState"],"-")},{}],9:[function(t,e,n){function r(t){function e(){s.emit("jsonp-end",[],p),t.removeEventListener("load",e,!1),t.removeEventListener("error",n,!1)}function n(){s.emit("jsonp-error",[],p),s.emit("jsonp-end",[],p),t.removeEventListener("load",e,!1),t.removeEventListener("error",n,!1)}var r=t&&"string"==typeof t.nodeName&&"script"===t.nodeName.toLowerCase();if(r){var o="function"==typeof t.addEventListener;if(o){var a=i(t.src);if(a){var u=c(a),d="function"==typeof u.parent[u.key];if(d){var p={};f.inPlace(u.parent,[u.key],"cb-",p),t.addEventListener("load",e,!1),t.addEventListener("error",n,!1),s.emit("new-jsonp",[t.src],p)}}}}}function o(){return"addEventListener"in window}function i(t){var e=t.match(u);return e?e[1]:null}function a(t,e){var n=t.match(p),r=n[1],o=n[3];return o?a(o,e[r]):e[r]}function c(t){var e=t.match(d);return e&&e.length>=3?{key:e[2],parent:a(e[1],window)}:{key:t,parent:window}}var s=t("ee").get("jsonp"),f=t(23)(s);if(e.exports=s,o()){var u=/[?&](?:callback|cb)=([^&#]+)/,d=/(.*)\.([^.]+)/,p=/^(\w+)(\.|$)(.*)$/,h=["appendChild","insertBefore","replaceChild"];f.inPlace(HTMLElement.prototype,h,"dom-"),f.inPlace(HTMLHeadElement.prototype,h,"dom-"),f.inPlace(HTMLBodyElement.prototype,h,"dom-"),s.on("dom-start",function(t){r(t[0])})}},{}],10:[function(t,e,n){var r=t("ee").get("mutation"),o=t(23)(r),i=NREUM.o.MO;e.exports=r,i&&(window.MutationObserver=function(t){return this instanceof i?new i(o(t,"fn-")):i.apply(this,arguments)},MutationObserver.prototype=i.prototype)},{}],11:[function(t,e,n){function r(t){var e=a.context(),n=c(t,"executor-",e),r=new f(n);return a.context(r).getCtx=function(){return e},a.emit("new-promise",[r,e],e),r}function o(t,e){return e}var i=t(23),a=t("ee").get("promise"),c=i(a),s=t(20),f=NREUM.o.PR;e.exports=a,f&&(window.Promise=r,["all","race"].forEach(function(t){var e=f[t];f[t]=function(n){function r(t){return function(){a.emit("propagate",[null,!o],i),o=o||!t}}var o=!1;s(n,function(e,n){Promise.resolve(n).then(r("all"===t),r(!1))});var i=e.apply(f,arguments),c=f.resolve(i);return c}}),["resolve","reject"].forEach(function(t){var e=f[t];f[t]=function(t){var n=e.apply(f,arguments);return t!==n&&a.emit("propagate",[t,!0],n),n}}),f.prototype["catch"]=function(t){return this.then(null,t)},f.prototype=Object.create(f.prototype,{constructor:{value:r}}),s(Object.getOwnPropertyNames(f),function(t,e){try{r[e]=f[e]}catch(n){}}),a.on("executor-start",function(t){t[0]=c(t[0],"resolve-",this),t[1]=c(t[1],"resolve-",this)}),a.on("executor-err",function(t,e,n){t[1](n)}),c.inPlace(f.prototype,["then"],"then-",o),a.on("then-start",function(t,e){this.promise=e,t[0]=c(t[0],"cb-",this),t[1]=c(t[1],"cb-",this)}),a.on("then-end",function(t,e,n){this.nextPromise=n;var r=this.promise;a.emit("propagate",[r,!0],n)}),a.on("cb-end",function(t,e,n){a.emit("propagate",[n,!0],this.nextPromise)}),a.on("propagate",function(t,e,n){this.getCtx&&!e||(this.getCtx=function(){if(t instanceof Promise)var e=a.context(t);return e&&e.getCtx?e.getCtx():this})}),r.toString=function(){return""+f})},{}],12:[function(t,e,n){var r=t("ee").get("raf"),o=t(23)(r),i="equestAnimationFrame";e.exports=r,o.inPlace(window,["r"+i,"mozR"+i,"webkitR"+i,"msR"+i],"raf-"),r.on("raf-start",function(t){t[0]=o(t[0],"fn-")})},{}],13:[function(t,e,n){function r(t,e,n){t[0]=a(t[0],"fn-",null,n)}function o(t,e,n){this.method=n,this.timerDuration=isNaN(t[1])?0:+t[1],t[0]=a(t[0],"fn-",this,n)}var i=t("ee").get("timer"),a=t(23)(i),c="setTimeout",s="setInterval",f="clearTimeout",u="-start",d="-";e.exports=i,a.inPlace(window,[c,"setImmediate"],c+d),a.inPlace(window,[s],s+d),a.inPlace(window,[f,"clearImmediate"],f+d),i.on(s+u,r),i.on(c+u,o)},{}],14:[function(t,e,n){function r(t,e){d.inPlace(e,["onreadystatechange"],"fn-",c)}function o(){var t=this,e=u.context(t);t.readyState>3&&!e.resolved&&(e.resolved=!0,u.emit("xhr-resolved",[],t)),d.inPlace(t,y,"fn-",c)}function i(t){b.push(t),l&&(x?x.then(a):v?v(a):(E=-E,P.data=E))}function a(){for(var t=0;t<b.length;t++)r([],b[t]);b.length&&(b=[])}function c(t,e){return e}function s(t,e){for(var n in t)e[n]=t[n];return e}t(6);var f=t("ee"),u=f.get("xhr"),d=t(23)(u),p=NREUM.o,h=p.XHR,l=p.MO,m=p.PR,v=p.SI,w="readystatechange",y=["onload","onerror","onabort","onloadstart","onloadend","onprogress","ontimeout"],b=[];e.exports=u;var g=window.XMLHttpRequest=function(t){var e=new h(t);try{u.emit("new-xhr",[e],e),e.addEventListener(w,o,!1)}catch(n){try{u.emit("internal-error",[n])}catch(r){}}return e};if(s(h,g),g.prototype=h.prototype,d.inPlace(g.prototype,["open","send"],"-xhr-",c),u.on("send-xhr-start",function(t,e){r(t,e),i(e)}),u.on("open-xhr-start",r),l){var x=m&&m.resolve();if(!v&&!m){var E=1,P=document.createTextNode(E);new l(a).observe(P,{characterData:!0})}}else f.on("fn-end",function(t){t[0]&&t[0].type===w||a()})},{}],15:[function(t,e,n){function r(t){var e=this.params,n=this.metrics;if(!this.ended){this.ended=!0;for(var r=0;r<d;r++)t.removeEventListener(u[r],this.listener,!1);if(!e.aborted){if(n.duration=a.now()-this.startTime,4===t.readyState){e.status=t.status;var i=o(t,this.lastSize);if(i&&(n.rxSize=i),this.sameOrigin){var s=t.getResponseHeader("X-NewRelic-App-Data");s&&(e.cat=s.split(", ").pop())}}else e.status=0;n.cbTime=this.cbTime,f.emit("xhr-done",[t],t),c("xhr",[e,n,this.startTime])}}}function o(t,e){var n=t.responseType;if("json"===n&&null!==e)return e;var r="arraybuffer"===n||"blob"===n||"json"===n?t.response:t.responseText;return l(r)}function i(t,e){var n=s(e),r=t.params;r.host=n.hostname+":"+n.port,r.pathname=n.pathname,t.sameOrigin=n.sameOrigin}var a=t("loader");if(a.xhrWrappable){var c=t("handle"),s=t(16),f=t("ee"),u=["load","error","abort","timeout"],d=u.length,p=t("id"),h=t(19),l=t(18),m=window.XMLHttpRequest;a.features.xhr=!0,t(14),f.on("new-xhr",function(t){var e=this;e.totalCbs=0,e.called=0,e.cbTime=0,e.end=r,e.ended=!1,e.xhrGuids={},e.lastSize=null,h&&(h>34||h<10)||window.opera||t.addEventListener("progress",function(t){e.lastSize=t.loaded},!1)}),f.on("open-xhr-start",function(t){this.params={method:t[0]},i(this,t[1]),this.metrics={}}),f.on("open-xhr-end",function(t,e){"loader_config"in NREUM&&"xpid"in NREUM.loader_config&&this.sameOrigin&&e.setRequestHeader("X-NewRelic-ID",NREUM.loader_config.xpid)}),f.on("send-xhr-start",function(t,e){var n=this.metrics,r=t[0],o=this;if(n&&r){var i=l(r);i&&(n.txSize=i)}this.startTime=a.now(),this.listener=function(t){try{"abort"===t.type&&(o.params.aborted=!0),("load"!==t.type||o.called===o.totalCbs&&(o.onloadCalled||"function"!=typeof e.onload))&&o.end(e)}catch(n){try{f.emit("internal-error",[n])}catch(r){}}};for(var c=0;c<d;c++)e.addEventListener(u[c],this.listener,!1)}),f.on("xhr-cb-time",function(t,e,n){this.cbTime+=t,e?this.onloadCalled=!0:this.called+=1,this.called!==this.totalCbs||!this.onloadCalled&&"function"==typeof n.onload||this.end(n)}),f.on("xhr-load-added",function(t,e){var n=""+p(t)+!!e;this.xhrGuids&&!this.xhrGuids[n]&&(this.xhrGuids[n]=!0,this.totalCbs+=1)}),f.on("xhr-load-removed",function(t,e){var n=""+p(t)+!!e;this.xhrGuids&&this.xhrGuids[n]&&(delete this.xhrGuids[n],this.totalCbs-=1)}),f.on("addEventListener-end",function(t,e){e instanceof m&&"load"===t[0]&&f.emit("xhr-load-added",[t[1],t[2]],e)}),f.on("removeEventListener-end",function(t,e){e instanceof m&&"load"===t[0]&&f.emit("xhr-load-removed",[t[1],t[2]],e)}),f.on("fn-start",function(t,e,n){e instanceof m&&("onload"===n&&(this.onload=!0),("load"===(t[0]&&t[0].type)||this.onload)&&(this.xhrCbStart=a.now()))}),f.on("fn-end",function(t,e){this.xhrCbStart&&f.emit("xhr-cb-time",[a.now()-this.xhrCbStart,this.onload,e],e)})}},{}],16:[function(t,e,n){e.exports=function(t){var e=document.createElement("a"),n=window.location,r={};e.href=t,r.port=e.port;var o=e.href.split("://");!r.port&&o[1]&&(r.port=o[1].split("/")[0].split("@").pop().split(":")[1]),r.port&&"0"!==r.port||(r.port="https"===o[0]?"443":"80"),r.hostname=e.hostname||n.hostname,r.pathname=e.pathname,r.protocol=o[0],"/"!==r.pathname.charAt(0)&&(r.pathname="/"+r.pathname);var i=!e.protocol||":"===e.protocol||e.protocol===n.protocol,a=e.hostname===document.domain&&e.port===n.port;return r.sameOrigin=i&&(!e.hostname||a),r}},{}],17:[function(t,e,n){function r(){}function o(t,e,n){return function(){return i(t,[f.now()].concat(c(arguments)),e?null:this,n),e?void 0:this}}var i=t("handle"),a=t(20),c=t(21),s=t("ee").get("tracer"),f=t("loader"),u=NREUM;"undefined"==typeof window.newrelic&&(newrelic=u);var d=["setPageViewName","setCustomAttribute","setErrorHandler","finished","addToTrace","inlineHit","addRelease"],p="api-",h=p+"ixn-";a(d,function(t,e){u[e]=o(p+e,!0,"api")}),u.addPageAction=o(p+"addPageAction",!0),u.setCurrentRouteName=o(p+"routeName",!0),e.exports=newrelic,u.interaction=function(){return(new r).get()};var l=r.prototype={createTracer:function(t,e){var n={},r=this,o="function"==typeof e;return i(h+"tracer",[f.now(),t,n],r),function(){if(s.emit((o?"":"no-")+"fn-start",[f.now(),r,o],n),o)try{return e.apply(this,arguments)}catch(t){throw s.emit("fn-err",[arguments,this,t],n),t}finally{s.emit("fn-end",[f.now()],n)}}}};a("setName,setAttribute,save,ignore,onEnd,getContext,end,get".split(","),function(t,e){l[e]=o(h+e)}),newrelic.noticeError=function(t){"string"==typeof t&&(t=new Error(t)),i("err",[t,f.now()])}},{}],18:[function(t,e,n){e.exports=function(t){if("string"==typeof t&&t.length)return t.length;if("object"==typeof t){if("undefined"!=typeof ArrayBuffer&&t instanceof ArrayBuffer&&t.byteLength)return t.byteLength;if("undefined"!=typeof Blob&&t instanceof Blob&&t.size)return t.size;if(!("undefined"!=typeof FormData&&t instanceof FormData))try{return JSON.stringify(t).length}catch(e){return}}}},{}],19:[function(t,e,n){var r=0,o=navigator.userAgent.match(/Firefox[\/\s](\d+\.\d+)/);o&&(r=+o[1]),e.exports=r},{}],20:[function(t,e,n){function r(t,e){var n=[],r="",i=0;for(r in t)o.call(t,r)&&(n[i]=e(r,t[r]),i+=1);return n}var o=Object.prototype.hasOwnProperty;e.exports=r},{}],21:[function(t,e,n){function r(t,e,n){e||(e=0),"undefined"==typeof n&&(n=t?t.length:0);for(var r=-1,o=n-e||0,i=Array(o<0?0:o);++r<o;)i[r]=t[e+r];return i}e.exports=r},{}],22:[function(t,e,n){e.exports={exists:"undefined"!=typeof window.performance&&window.performance.timing&&"undefined"!=typeof window.performance.timing.navigationStart}},{}],23:[function(t,e,n){function r(t){return!(t&&t instanceof Function&&t.apply&&!t[a])}var o=t("ee"),i=t(21),a="nr@original",c=Object.prototype.hasOwnProperty,s=!1;e.exports=function(t,e){function n(t,e,n,o){function nrWrapper(){var r,a,c,s;try{a=this,r=i(arguments),c="function"==typeof n?n(r,a):n||{}}catch(f){p([f,"",[r,a,o],c])}u(e+"start",[r,a,o],c);try{return s=t.apply(a,r)}catch(d){throw u(e+"err",[r,a,d],c),d}finally{u(e+"end",[r,a,s],c)}}return r(t)?t:(e||(e=""),nrWrapper[a]=t,d(t,nrWrapper),nrWrapper)}function f(t,e,o,i){o||(o="");var a,c,s,f="-"===o.charAt(0);for(s=0;s<e.length;s++)c=e[s],a=t[c],r(a)||(t[c]=n(a,f?c+o:o,i,c))}function u(n,r,o){if(!s||e){var i=s;s=!0;try{t.emit(n,r,o,e)}catch(a){p([a,n,r,o])}s=i}}function d(t,e){if(Object.defineProperty&&Object.keys)try{var n=Object.keys(t);return n.forEach(function(n){Object.defineProperty(e,n,{get:function(){return t[n]},set:function(e){return t[n]=e,e}})}),e}catch(r){p([r])}for(var o in t)c.call(t,o)&&(e[o]=t[o]);return e}function p(e){try{t.emit("internal-error",e)}catch(n){}}return t||(t=o),n.inPlace=f,n.flag=a,n}},{}],ee:[function(t,e,n){function r(){}function o(t){function e(t){return t&&t instanceof r?t:t?s(t,c,i):i()}function n(n,r,o,i){if(!p.aborted||i){t&&t(n,r,o);for(var a=e(o),c=l(n),s=c.length,f=0;f<s;f++)c[f].apply(a,r);var d=u[y[n]];return d&&d.push([b,n,r,a]),a}}function h(t,e){w[t]=l(t).concat(e)}function l(t){return w[t]||[]}function m(t){return d[t]=d[t]||o(n)}function v(t,e){f(t,function(t,n){e=e||"feature",y[n]=e,e in u||(u[e]=[])})}var w={},y={},b={on:h,emit:n,get:m,listeners:l,context:e,buffer:v,abort:a,aborted:!1};return b}function i(){return new r}function a(){(u.api||u.feature)&&(p.aborted=!0,u=p.backlog={})}var c="nr@context",s=t("gos"),f=t(20),u={},d={},p=e.exports=o();p.backlog=u},{}],gos:[function(t,e,n){function r(t,e,n){if(o.call(t,e))return t[e];var r=n();if(Object.defineProperty&&Object.keys)try{return Object.defineProperty(t,e,{value:r,writable:!0,enumerable:!1}),r}catch(i){}return t[e]=r,r}var o=Object.prototype.hasOwnProperty;e.exports=r},{}],handle:[function(t,e,n){function r(t,e,n,r){o.buffer([t],r),o.emit(t,e,n)}var o=t("ee").get("handle");e.exports=r,r.ee=o},{}],id:[function(t,e,n){function r(t){var e=typeof t;return!t||"object"!==e&&"function"!==e?-1:t===window?0:a(t,i,function(){return o++})}var o=1,i="nr@id",a=t("gos");e.exports=r},{}],loader:[function(t,e,n){function r(){if(!x++){var t=g.info=NREUM.info,e=p.getElementsByTagName("script")[0];if(setTimeout(u.abort,3e4),!(t&&t.licenseKey&&t.applicationID&&e))return u.abort();f(y,function(e,n){t[e]||(t[e]=n)}),s("mark",["onload",a()+g.offset],null,"api");var n=p.createElement("script");n.src="https://"+t.agent,e.parentNode.insertBefore(n,e)}}function o(){"complete"===p.readyState&&i()}function i(){s("mark",["domContent",a()+g.offset],null,"api")}function a(){return E.exists&&performance.now?Math.round(performance.now()):(c=Math.max((new Date).getTime(),c))-g.offset}var c=(new Date).getTime(),s=t("handle"),f=t(20),u=t("ee"),d=window,p=d.document,h="addEventListener",l="attachEvent",m=d.XMLHttpRequest,v=m&&m.prototype;NREUM.o={ST:setTimeout,SI:d.setImmediate,CT:clearTimeout,XHR:m,REQ:d.Request,EV:d.Event,PR:d.Promise,MO:d.MutationObserver};var w=""+location,y={beacon:"bam.nr-data.net",errorBeacon:"bam.nr-data.net",agent:"js-agent.newrelic.com/nr-spa-1071.min.js"},b=m&&v&&v[h]&&!/CriOS/.test(navigator.userAgent),g=e.exports={offset:c,now:a,origin:w,features:{},xhrWrappable:b};t(17),p[h]?(p[h]("DOMContentLoaded",i,!1),d[h]("load",r,!1)):(p[l]("onreadystatechange",o),d[l]("onload",r)),s("mark",["firstbyte",c],null,"api");var x=0,E=t(22)},{}]},{},["loader",2,15,5,3,4]);</script>
  


<meta id="bb-canon-url" name="bb-canon-url" content="https://bitbucket.org">
<meta name="bb-api-canon-url" content="https://api.bitbucket.org">


<meta name="bb-commit-hash" content="3b14e1f927c2">
<meta name="bb-app-node" content="app-148">
<meta name="bb-view-name" content="bitbucket.apps.repo2.views.filebrowse">
<meta name="ignore-whitespace" content="False">
<meta name="tab-size" content="None">
<meta name="locale" content="en">
<meta name="application-name" content="Bitbucket">
<meta name="apple-mobile-web-app-title" content="Bitbucket">
<meta name="slack-app-id" content="A8W8QLZD1">


<meta name="theme-color" content="#0049B0">
<meta name="msapplication-TileColor" content="#0052CC">
<meta name="msapplication-TileImage" content="https://d301sr5gafysq2.cloudfront.net/3b14e1f927c2/img/logos/bitbucket/mstile-150x150.png">
<link rel="apple-touch-icon" sizes="180x180" type="image/png" href="https://d301sr5gafysq2.cloudfront.net/3b14e1f927c2/img/logos/bitbucket/apple-touch-icon.png">
<link rel="icon" sizes="192x192" type="image/png" href="https://d301sr5gafysq2.cloudfront.net/3b14e1f927c2/img/logos/bitbucket/android-chrome-192x192.png">

<link rel="icon" sizes="16x16 24x24 32x32 64x64" type="image/x-icon" href="/favicon.ico?v=2">
<link rel="mask-icon" href="https://d301sr5gafysq2.cloudfront.net/3b14e1f927c2/img/logos/bitbucket/safari-pinned-tab.svg" color="#0052CC">

<link rel="search" type="application/opensearchdescription+xml" href="/opensearch.xml" title="Bitbucket">

  <meta name="description" content="">
  
  
    
  



  <link rel="stylesheet" href="https://d301sr5gafysq2.cloudfront.net/3b14e1f927c2/css/entry/vendor.css" />
<link rel="stylesheet" href="https://d301sr5gafysq2.cloudfront.net/3b14e1f927c2/css/entry/app.css" />



  <link rel="stylesheet" href="https://d301sr5gafysq2.cloudfront.net/3b14e1f927c2/css/entry/adg3-skeleton-nav.css">
  <link rel="stylesheet" href="https://d301sr5gafysq2.cloudfront.net/3b14e1f927c2/css/entry/adg3.css">
  
  <script nonce="">
  window.__sentry__ = {"dsn": "https://ea49358f525d4019945839a3d7a8292a@sentry.io/159509", "release": "3b14e1f927c2 (canary-production)", "tags": {"project": "bitbucket-core"}, "environment": "canary-production"};
</script>
<script src="https://d301sr5gafysq2.cloudfront.net/3b14e1f927c2/dist/webpack/sentry.js" nonce=""></script>
  <script src="https://d301sr5gafysq2.cloudfront.net/3b14e1f927c2/dist/webpack/early.js" nonce=""></script>
  
  
  
    <link href="/Dannephoto/mlv_app_compiler/rss" rel="alternate nofollow" type="application/rss+xml" title="RSS feed for mlv_app_compiler" />

</head>
<body class="production adg3 "
    data-static-url="https://d301sr5gafysq2.cloudfront.net/3b14e1f927c2/"
data-base-url="https://bitbucket.org"
data-no-avatar-image="https://d301sr5gafysq2.cloudfront.net/3b14e1f927c2/img/default_avatar/user_blue.svg"
data-current-user="{&quot;isKbdShortcutsEnabled&quot;: true, &quot;isSshEnabled&quot;: false, &quot;isAuthenticated&quot;: false}"
data-atlassian-id="{&quot;loginStatusUrl&quot;: &quot;https://id.atlassian.com/profile/rest/profile&quot;}"
data-settings="{&quot;MENTIONS_MIN_QUERY_LENGTH&quot;: 3}"

data-current-repo="{&quot;scm&quot;: &quot;hg&quot;, &quot;readOnly&quot;: false, &quot;mainbranch&quot;: {&quot;name&quot;: &quot;default&quot;}, &quot;uuid&quot;: &quot;ab93a1b6-abba-4dda-98c1-23111e57e84b&quot;, &quot;language&quot;: &quot;&quot;, &quot;owner&quot;: {&quot;username&quot;: &quot;Dannephoto&quot;, &quot;uuid&quot;: &quot;a62aa76c-79ee-415b-8891-5c4c5893288e&quot;, &quot;isTeam&quot;: false}, &quot;fullslug&quot;: &quot;Dannephoto/mlv_app_compiler&quot;, &quot;slug&quot;: &quot;mlv_app_compiler&quot;, &quot;id&quot;: 34067892, &quot;pygmentsLanguage&quot;: null}"
data-current-cset="78e6acd69e79a156e1038e493fed984e351f8763"






data-browser-monitoring="true"
data-switch-create-pullrequest-commit-status="true"




>
<div
  id="page"
  data-mobile-nav
>
  
    <div id="adg3-navigation"
  
  
  
   data-mobile-nav
  >
  <nav class="skeleton-nav">
    <div class="skeleton-nav--left">
      <div class="skeleton-nav--left-top">
        <ul class="skeleton-nav--items">
          <li></li>
          <li></li>
          <li></li>
          <li class="skeleton--icon"></li>
          <li class="skeleton--icon-sub"></li>
          <li class="skeleton--icon-sub"></li>
          <li class="skeleton--icon-sub"></li>
          <li class="skeleton--icon-sub"></li>
          <li class="skeleton--icon-sub"></li>
          <li class="skeleton--icon-sub"></li>
        </ul>
      </div>
      <div class="skeleton-nav--left-bottom">
        <div class="skeleton-nav--left-bottom-wrapper">
          <div class="skeleton-nav--item-help"></div>
          <div class="skeleton-nav--item-profile"></div>
        </div>
      </div>
    </div>
    <div class="skeleton-nav--right">
      <ul class="skeleton-nav--items-wide">
        <li class="skeleton--icon-logo-container">
          <div class="skeleton--icon-container"></div>
          <div class="skeleton--icon-description"></div>
          <div class="skeleton--icon-logo"></div>
        </li>
        <li>
          <div class="skeleton--icon-small"></div>
          <div class="skeleton-nav--item-wide-content"></div>
        </li>
        <li>
          <div class="skeleton--icon-small"></div>
          <div class="skeleton-nav--item-wide-content"></div>
        </li>
        <li>
          <div class="skeleton--icon-small"></div>
          <div class="skeleton-nav--item-wide-content"></div>
        </li>
        <li>
          <div class="skeleton--icon-small"></div>
          <div class="skeleton-nav--item-wide-content"></div>
        </li>
        <li>
          <div class="skeleton--icon-small"></div>
          <div class="skeleton-nav--item-wide-content"></div>
        </li>
        <li>
          <div class="skeleton--icon-small"></div>
          <div class="skeleton-nav--item-wide-content"></div>
        </li>
      </ul>
    </div>
  </nav>
</div>

    <div id="wrapper">
      
  


      
  <div id="nps-survey-container"></div>

 

      
  

<div id="account-warning" data-module="header/account-warning"
  data-unconfirmed-addresses="false"
  data-no-addresses="false"
  
></div>



      
  
<header id="aui-message-bar">
  
</header>


      <div id="content" role="main">

        
          <header class="app-header">
            <div class="app-header--primary">
              
                <div class="app-header--context">
                  <div class="app-header--breadcrumbs">
                    
  <ol class="aui-nav aui-nav-breadcrumbs">
    <li>
  <a href="/Dannephoto/">danne</a>
</li>

<li>
  <a href="/Dannephoto/mlv_app_compiler">mlv_app_compiler</a>
</li>
    
  <li>
    <a href="/Dannephoto/mlv_app_compiler/src">
      Source
    </a>
  </li>

  </ol>

                  </div>
                  <h1 class="app-header--heading">
                    <span class="file-path">main.command</span>
                  </h1>
                </div>
              
            </div>

            <div class="app-header--secondary">
              
                
              
            </div>
          </header>
        

        
        
  <div class="aui-page-panel ">
    <div class="hidden">
  
  
  </div>
    <div class="aui-page-panel-inner">

      <div
        id="repo-content"
        class="aui-page-panel-content forks-enabled"
        data-module="repo/index"
        
      >
        
        
  <div id="source-container" class="maskable" data-module="repo/source/index">
    



<header id="source-path">
  
    <div class="labels labels-csv">
      <div class="aui-buttons">
        <button data-branches-tags-url="/api/1.0/repositories/Dannephoto/mlv_app_compiler/branches-tags"
                data-module="components/branch-dialog"
                
                class="aui-button branch-dialog-trigger" title="default">
          
            
              <span class="aui-icon aui-icon-small aui-iconfont-devtools-branch">Branch</span>
            
            <span class="name">default</span>
          
          <span class="aui-icon-dropdown"></span>
        </button>
        <button class="aui-button" id="checkout-branch-button"
                title="Check out this branch">
          <span class="aui-icon aui-icon-small aui-iconfont-devtools-clone">Check out branch</span>
          <span class="aui-icon-dropdown"></span>
        </button>
      </div>
      
    
    
  
    </div>
  
  
    <div class="secondary-actions">
      <div class="aui-buttons">
        
          <a href="/Dannephoto/mlv_app_compiler/src/78e6acd69e79/Mlv_App_compiler.app/Contents/main.command?at=default"
            class="aui-button pjax-trigger source-toggle" aria-pressed="true">
            Source
          </a>
          <a href="/Dannephoto/mlv_app_compiler/diff/Mlv_App_compiler.app/Contents/main.command?diff2=78e6acd69e79&at=default"
            class="aui-button pjax-trigger diff-toggle"
            title="Diff to previous change">
            Diff
          </a>
          <a href="/Dannephoto/mlv_app_compiler/history-node/78e6acd69e79/Mlv_App_compiler.app/Contents/main.command?at=default"
            class="aui-button pjax-trigger history-toggle">
            History
          </a>
        
      </div>

      
      

    </div>
  
  <h1>
    
      
        <a href="/Dannephoto/mlv_app_compiler/src/78e6acd69e79?at=default"
          class="pjax-trigger root" title="Dannephoto/mlv_app_compiler at 78e6acd69e79">mlv_app_compiler</a> /
      
      
        
          
            <a href="/Dannephoto/mlv_app_compiler/src/78e6acd69e79/Mlv_App_compiler.app/?at=default"
              class="pjax-trigger directory-name">Mlv_App_compiler.app</a> /
          
        
      
        
          
            <a href="/Dannephoto/mlv_app_compiler/src/78e6acd69e79/Mlv_App_compiler.app/Contents/?at=default"
              class="pjax-trigger directory-name">Contents</a> /
          
        
      
        
          
            <span class="file-name">main.command</span>
          
        
      
    
  </h1>
  
    
    
  
  <div class="clearfix"></div>
</header>


  
    
  

  <div id="editor-container" class="maskable"
       data-module="repo/source/editor"
       data-repo-id="34067892"
       data-owner="Dannephoto"
       data-slug="mlv_app_compiler"
       data-is-writer="false"
       data-has-push-access="true"
       data-hash="78e6acd69e79a156e1038e493fed984e351f8763"
       data-branch="default"
       data-path="Mlv_App_compiler.app/Contents/main.command"
       data-source-url="/api/internal/repositories/Dannephoto/mlv_app_compiler/src/78e6acd69e79a156e1038e493fed984e351f8763/Mlv_App_compiler.app/Contents/main.command">
    <div id="source-view" class="file-source-container" data-module="repo/source/view-file" data-is-lfs="false">
      <div class="toolbar">
        <div class="primary">
          <div class="aui-buttons">
            
              <button id="file-history-trigger" class="aui-button aui-button-light changeset-info"
                      data-changeset="78e6acd69e79a156e1038e493fed984e351f8763"
                      data-path="Mlv_App_compiler.app/Contents/main.command"
                      data-current="78e6acd69e79a156e1038e493fed984e351f8763">
                 

  <div class="aui-avatar aui-avatar-xsmall">
    <div class="aui-avatar-inner">
      <img src="https://bitbucket.org/account/Dannephoto/avatar/16/?ts=1529074421">
    </div>
  </div>
  <span class="changeset-hash">78e6acd</span>
  <time datetime="2018-06-04T14:20:56+00:00" class="timestamp"></time>
  <span class="aui-icon-dropdown"></span>

              </button>
            
          </div>
          
          <a href="/Dannephoto/mlv_app_compiler/full-commit/78e6acd69e79/Mlv_App_compiler.app/Contents/main.command" id="full-commit-link"
             title="View full commit 78e6acd">Full commit</a>
        </div>
        <div class="secondary">
          
          <div class="aui-buttons">
            
              <a href="/Dannephoto/mlv_app_compiler/annotate/78e6acd69e79a156e1038e493fed984e351f8763/Mlv_App_compiler.app/Contents/main.command?at=default"
                 class="aui-button aui-button-light pjax-trigger blame-link">Annotate</a>
              
                
                <a data-embed-url="https://bitbucket.org/Dannephoto/mlv_app_compiler/src/78e6acd69e79a156e1038e493fed984e351f8763/Mlv_App_compiler.app/Contents/main.command?embed=t" class="aui-button aui-button-light js-embed-link">
                  Embed
                </a>
              
            
            <a href="/Dannephoto/mlv_app_compiler/raw/78e6acd69e79a156e1038e493fed984e351f8763/Mlv_App_compiler.app/Contents/main.command" class="aui-button aui-button-light raw-link">Raw</a>
          </div>
          
            <button id="file-edit-button" class="edit-button aui-button aui-button-light" disabled="disabled" aria-disabled="true">
              Edit
              <span class="edit-button-overlay" title="Log in to edit this file"></span>
            </button>
          
        </div>

        <div id="fileview-dropdown"
            class="aui-dropdown2 aui-style-default"
            data-fileview-container="#fileview-container"
            
            
            data-fileview-button="#fileview-trigger"
            data-module="connect/fileview">
          <div class="aui-dropdown2-section">
            <ul>
              <li>
                <a class="aui-dropdown2-radio aui-dropdown2-checked"
                    data-fileview-id="-1"
                    data-fileview-loaded="true"
                    data-fileview-target="#fileview-original"
                    data-fileview-connection-key=""
                    data-fileview-module-key="file-view-default">
                  Default File Viewer
                </a>
              </li>
              
            </ul>
          </div>
        </div>

        <div class="clearfix"></div>
      </div>
      <div id="fileview-container">
        <div id="fileview-original"
            class="fileview"
            data-module="repo/source/highlight-lines"
            data-fileview-loaded="true">
          


  
    <div class="file-source">
      <table class="codehilite highlighttable"><tr><td class="linenos"><div class="linenodiv"><pre><a href="#main.command-1">  1</a>
<a href="#main.command-2">  2</a>
<a href="#main.command-3">  3</a>
<a href="#main.command-4">  4</a>
<a href="#main.command-5">  5</a>
<a href="#main.command-6">  6</a>
<a href="#main.command-7">  7</a>
<a href="#main.command-8">  8</a>
<a href="#main.command-9">  9</a>
<a href="#main.command-10"> 10</a>
<a href="#main.command-11"> 11</a>
<a href="#main.command-12"> 12</a>
<a href="#main.command-13"> 13</a>
<a href="#main.command-14"> 14</a>
<a href="#main.command-15"> 15</a>
<a href="#main.command-16"> 16</a>
<a href="#main.command-17"> 17</a>
<a href="#main.command-18"> 18</a>
<a href="#main.command-19"> 19</a>
<a href="#main.command-20"> 20</a>
<a href="#main.command-21"> 21</a>
<a href="#main.command-22"> 22</a>
<a href="#main.command-23"> 23</a>
<a href="#main.command-24"> 24</a>
<a href="#main.command-25"> 25</a>
<a href="#main.command-26"> 26</a>
<a href="#main.command-27"> 27</a>
<a href="#main.command-28"> 28</a>
<a href="#main.command-29"> 29</a>
<a href="#main.command-30"> 30</a>
<a href="#main.command-31"> 31</a>
<a href="#main.command-32"> 32</a>
<a href="#main.command-33"> 33</a>
<a href="#main.command-34"> 34</a>
<a href="#main.command-35"> 35</a>
<a href="#main.command-36"> 36</a>
<a href="#main.command-37"> 37</a>
<a href="#main.command-38"> 38</a>
<a href="#main.command-39"> 39</a>
<a href="#main.command-40"> 40</a>
<a href="#main.command-41"> 41</a>
<a href="#main.command-42"> 42</a>
<a href="#main.command-43"> 43</a>
<a href="#main.command-44"> 44</a>
<a href="#main.command-45"> 45</a>
<a href="#main.command-46"> 46</a>
<a href="#main.command-47"> 47</a>
<a href="#main.command-48"> 48</a>
<a href="#main.command-49"> 49</a>
<a href="#main.command-50"> 50</a>
<a href="#main.command-51"> 51</a>
<a href="#main.command-52"> 52</a>
<a href="#main.command-53"> 53</a>
<a href="#main.command-54"> 54</a>
<a href="#main.command-55"> 55</a>
<a href="#main.command-56"> 56</a>
<a href="#main.command-57"> 57</a>
<a href="#main.command-58"> 58</a>
<a href="#main.command-59"> 59</a>
<a href="#main.command-60"> 60</a>
<a href="#main.command-61"> 61</a>
<a href="#main.command-62"> 62</a>
<a href="#main.command-63"> 63</a>
<a href="#main.command-64"> 64</a>
<a href="#main.command-65"> 65</a>
<a href="#main.command-66"> 66</a>
<a href="#main.command-67"> 67</a>
<a href="#main.command-68"> 68</a>
<a href="#main.command-69"> 69</a>
<a href="#main.command-70"> 70</a>
<a href="#main.command-71"> 71</a>
<a href="#main.command-72"> 72</a>
<a href="#main.command-73"> 73</a>
<a href="#main.command-74"> 74</a>
<a href="#main.command-75"> 75</a>
<a href="#main.command-76"> 76</a>
<a href="#main.command-77"> 77</a>
<a href="#main.command-78"> 78</a>
<a href="#main.command-79"> 79</a>
<a href="#main.command-80"> 80</a>
<a href="#main.command-81"> 81</a>
<a href="#main.command-82"> 82</a>
<a href="#main.command-83"> 83</a>
<a href="#main.command-84"> 84</a>
<a href="#main.command-85"> 85</a>
<a href="#main.command-86"> 86</a>
<a href="#main.command-87"> 87</a>
<a href="#main.command-88"> 88</a>
<a href="#main.command-89"> 89</a>
<a href="#main.command-90"> 90</a>
<a href="#main.command-91"> 91</a>
<a href="#main.command-92"> 92</a>
<a href="#main.command-93"> 93</a>
<a href="#main.command-94"> 94</a>
<a href="#main.command-95"> 95</a>
<a href="#main.command-96"> 96</a>
<a href="#main.command-97"> 97</a>
<a href="#main.command-98"> 98</a>
<a href="#main.command-99"> 99</a>
<a href="#main.command-100">100</a>
<a href="#main.command-101">101</a>
<a href="#main.command-102">102</a>
<a href="#main.command-103">103</a>
<a href="#main.command-104">104</a>
<a href="#main.command-105">105</a>
<a href="#main.command-106">106</a>
<a href="#main.command-107">107</a>
<a href="#main.command-108">108</a>
<a href="#main.command-109">109</a>
<a href="#main.command-110">110</a>
<a href="#main.command-111">111</a>
<a href="#main.command-112">112</a>
<a href="#main.command-113">113</a>
<a href="#main.command-114">114</a>
<a href="#main.command-115">115</a>
<a href="#main.command-116">116</a>
<a href="#main.command-117">117</a>
<a href="#main.command-118">118</a>
<a href="#main.command-119">119</a>
<a href="#main.command-120">120</a>
<a href="#main.command-121">121</a>
<a href="#main.command-122">122</a>
<a href="#main.command-123">123</a>
<a href="#main.command-124">124</a>
<a href="#main.command-125">125</a>
<a href="#main.command-126">126</a>
<a href="#main.command-127">127</a>
<a href="#main.command-128">128</a>
<a href="#main.command-129">129</a>
<a href="#main.command-130">130</a>
<a href="#main.command-131">131</a>
<a href="#main.command-132">132</a>
<a href="#main.command-133">133</a>
<a href="#main.command-134">134</a>
<a href="#main.command-135">135</a>
<a href="#main.command-136">136</a>
<a href="#main.command-137">137</a>
<a href="#main.command-138">138</a>
<a href="#main.command-139">139</a>
<a href="#main.command-140">140</a>
<a href="#main.command-141">141</a>
<a href="#main.command-142">142</a>
<a href="#main.command-143">143</a>
<a href="#main.command-144">144</a>
<a href="#main.command-145">145</a>
<a href="#main.command-146">146</a>
<a href="#main.command-147">147</a>
<a href="#main.command-148">148</a>
<a href="#main.command-149">149</a>
<a href="#main.command-150">150</a>
<a href="#main.command-151">151</a>
<a href="#main.command-152">152</a>
<a href="#main.command-153">153</a>
<a href="#main.command-154">154</a>
<a href="#main.command-155">155</a>
<a href="#main.command-156">156</a>
<a href="#main.command-157">157</a>
<a href="#main.command-158">158</a>
<a href="#main.command-159">159</a>
<a href="#main.command-160">160</a>
<a href="#main.command-161">161</a>
<a href="#main.command-162">162</a>
<a href="#main.command-163">163</a>
<a href="#main.command-164">164</a>
<a href="#main.command-165">165</a>
<a href="#main.command-166">166</a>
<a href="#main.command-167">167</a>
<a href="#main.command-168">168</a>
<a href="#main.command-169">169</a>
<a href="#main.command-170">170</a>
<a href="#main.command-171">171</a>
<a href="#main.command-172">172</a>
<a href="#main.command-173">173</a>
<a href="#main.command-174">174</a>
<a href="#main.command-175">175</a>
<a href="#main.command-176">176</a>
<a href="#main.command-177">177</a>
<a href="#main.command-178">178</a>
<a href="#main.command-179">179</a>
<a href="#main.command-180">180</a>
<a href="#main.command-181">181</a>
<a href="#main.command-182">182</a>
<a href="#main.command-183">183</a>
<a href="#main.command-184">184</a>
<a href="#main.command-185">185</a></pre></div></td><td class="code"><div class="codehilite highlight"><pre><span></span><a name="main.command-1"></a>#GNU public license
<a name="main.command-2"></a>#This program is free software; you can redistribute it and/or
<a name="main.command-3"></a> # modify it under the terms of the GNU General Public License
<a name="main.command-4"></a> # as published by the Free Software Foundation; either version 2
<a name="main.command-5"></a> # of the License, or (at your option) any later version.
<a name="main.command-6"></a> # 
<a name="main.command-7"></a> # This program is distributed in the hope that it will be useful,
<a name="main.command-8"></a> # but WITHOUT ANY WARRANTY; without even the implied warranty of
<a name="main.command-9"></a> # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
<a name="main.command-10"></a> # GNU General Public License for more details.
<a name="main.command-11"></a> # 
<a name="main.command-12"></a> # You should have received a copy of the GNU General Public License
<a name="main.command-13"></a> # along with this program; if not, write to the
<a name="main.command-14"></a> # Free Software Foundation, Inc.,
<a name="main.command-15"></a> # 51 Franklin Street, Fifth Floor,
<a name="main.command-16"></a> # Boston, MA  02110-1301, USA.
<a name="main.command-17"></a>
<a name="main.command-18"></a>
<a name="main.command-19"></a>#!/usr/bin/env bash
<a name="main.command-20"></a>
<a name="main.command-21"></a>#start in user directory
<a name="main.command-22"></a>cd ~
<a name="main.command-23"></a>
<a name="main.command-24"></a>if ! [ -d /Library/Developer/CommandLineTools ]
<a name="main.command-25"></a>then
<a name="main.command-26"></a>xcode-select --install
<a name="main.command-27"></a>fi
<a name="main.command-28"></a>
<a name="main.command-29"></a>#check for dependencies
<a name="main.command-30"></a>if ! [ -f /usr/local/bin/brew ]
<a name="main.command-31"></a>then
<a name="main.command-32"></a>/usr/bin/ruby -e &quot;$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)&quot;
<a name="main.command-33"></a>fi
<a name="main.command-34"></a>
<a name="main.command-35"></a>#check for qt versions
<a name="main.command-36"></a>if ! [ -d /usr/local/Cellar/qt/5.1* ]
<a name="main.command-37"></a>then
<a name="main.command-38"></a>brew install qt5
<a name="main.command-39"></a>brew upgrade qt5
<a name="main.command-40"></a>fi
<a name="main.command-41"></a>
<a name="main.command-42"></a>if ! [ -d ~/MLV-App-master ]
<a name="main.command-43"></a>then
<a name="main.command-44"></a>git clone https://github.com/ilia3101/MLV-App.git MLV-App-master
<a name="main.command-45"></a>cd ~/MLV-App-master
<a name="main.command-46"></a>else
<a name="main.command-47"></a>echo &quot;updating MLV-App-master source&quot;
<a name="main.command-48"></a>cd ~/MLV-App-master
<a name="main.command-49"></a>git pull
<a name="main.command-50"></a>fi
<a name="main.command-51"></a>
<a name="main.command-52"></a>printf &#39;\e[8;18;70t&#39;
<a name="main.command-53"></a>printf &#39;\e[3;410;0t&#39;
<a name="main.command-54"></a>clear
<a name="main.command-55"></a>while :
<a name="main.command-56"></a>do 
<a name="main.command-57"></a>cat&lt;&lt;EOF
<a name="main.command-58"></a>
<a name="main.command-59"></a>----------------
<a name="main.command-60"></a>$(tput bold)MLV App compiler$(tput sgr0)(thanks to Ilia3101,masc,bouncyball)
<a name="main.command-61"></a>----------------
<a name="main.command-62"></a>
<a name="main.command-63"></a>current branch:$(tput bold)$(tput setaf 4) $(git branch | awk &#39;/\*/ { print $2; }&#39;)$(tput sgr0)
<a name="main.command-64"></a>
<a name="main.command-65"></a>$(tput bold)$(tput setaf 1)(c)   compile MLV App$(tput sgr0)
<a name="main.command-66"></a>$(tput bold)$(tput setaf 1)(b)   check out branches$(tput sgr0)
<a name="main.command-67"></a>$(tput bold)$(tput setaf 1)(m)   make clean$(tput sgr0)
<a name="main.command-68"></a>
<a name="main.command-69"></a>$(tput bold)(q)   quit this compiler$(tput sgr0)
<a name="main.command-70"></a>
<a name="main.command-71"></a>Please enter your selection number below and press enter:
<a name="main.command-72"></a>EOF
<a name="main.command-73"></a>read input_variable
<a name="main.command-74"></a>i=$input_variable
<a name="main.command-75"></a>case &quot;$i&quot; in
<a name="main.command-76"></a>
<a name="main.command-77"></a>    &quot;co&quot;) 
<a name="main.command-78"></a>clear
<a name="main.command-79"></a>echo &quot;Welcome to the wonderful world of Cocoa.&quot;
<a name="main.command-80"></a>sleep 2
<a name="main.command-81"></a>echo &quot;&quot;
<a name="main.command-82"></a>echo &quot;This version is what brought MLV app to life through Ilia3101&quot;
<a name="main.command-83"></a>sleep 2
<a name="main.command-84"></a>echo &quot;&quot;
<a name="main.command-85"></a>echo &quot;Most features are old and might not be working!&quot;
<a name="main.command-86"></a>sleep 2
<a name="main.command-87"></a>echo &quot;&quot;
<a name="main.command-88"></a>echo &quot;have fun!&quot;
<a name="main.command-89"></a>sleep 2
<a name="main.command-90"></a>cd ~/MLV-App-master/platform/qt/
<a name="main.command-91"></a>make clean 
<a name="main.command-92"></a>cd ~/MLV-App-master/platform/cocoa/
<a name="main.command-93"></a>make clean 
<a name="main.command-94"></a>cd platform/cocoa
<a name="main.command-95"></a>make app -j4
<a name="main.command-96"></a>open .
<a name="main.command-97"></a>echo &quot;
<a name="main.command-98"></a>
<a name="main.command-99"></a>scroll upwards to check terminal outcome.&quot;
<a name="main.command-100"></a>    ;;
<a name="main.command-101"></a>
<a name="main.command-102"></a>    &quot;c&quot;) 
<a name="main.command-103"></a>clear
<a name="main.command-104"></a>echo &quot;let´s clean repo first(make clean)!&quot;
<a name="main.command-105"></a>sleep 1
<a name="main.command-106"></a>cd ~/MLV-App-master/platform/qt/
<a name="main.command-107"></a>make clean 
<a name="main.command-108"></a>cd ~/MLV-App-master/platform/cocoa/
<a name="main.command-109"></a>make clean 
<a name="main.command-110"></a>cd ~/MLV-App-master/platform &amp;&amp; \
<a name="main.command-111"></a>rm -r Mlv_app_master
<a name="main.command-112"></a>mkdir -p Mlv_app_master &amp;&amp; \
<a name="main.command-113"></a>cd Mlv_app_master &amp;&amp; \
<a name="main.command-114"></a>$(ls -d -t /usr/local/Cellar/qt/5* | head -1 | tr -d &#39;:&#39;)/bin/qmake ~/MLV-App-master/platform/qt/MLVApp.pro -spec macx-clang CONFIG+=x86_64 CONFIG+=release &amp;&amp; /usr/bin/make -j4 &amp;&amp; $(ls -d -t /usr/local/Cellar/qt/5* | head -1 | tr -d &#39;:&#39;)/bin/macdeployqt ~/MLV-App-master/platform/Mlv_app_master/MLV\ App.app &amp;&amp; \
<a name="main.command-115"></a>make clean &amp;&amp; \
<a name="main.command-116"></a>open ~/MLV-App-master/platform/Mlv_app_master/
<a name="main.command-117"></a>echo &quot;
<a name="main.command-118"></a>
<a name="main.command-119"></a>scroll upwards to check terminal outcome.&quot;
<a name="main.command-120"></a>    ;;
<a name="main.command-121"></a>
<a name="main.command-122"></a>    &quot;b&quot;)
<a name="main.command-123"></a>printf &#39;\e[8;18;70t&#39;
<a name="main.command-124"></a>printf &#39;\e[3;410;0t&#39;
<a name="main.command-125"></a>while :
<a name="main.command-126"></a>do 
<a name="main.command-127"></a>branches=$(git branch -a | awk &#39;{printf(&quot;%01d %s\n&quot;, NR, $0)}&#39; | cut -d &#39;/&#39; -f3 | cut -d &#39; &#39; -f3)
<a name="main.command-128"></a>/usr/bin/osascript -e &#39;tell application &quot;System Events&quot; to tell process &quot;Terminal&quot; to keystroke &quot;k&quot; using command down&#39;
<a name="main.command-129"></a>clear
<a name="main.command-130"></a>cat&lt;&lt;EOF
<a name="main.command-131"></a>
<a name="main.command-132"></a>current branch:$(tput bold)$(tput setaf 4) $(git branch | awk &#39;/\*/ { print $2; }&#39;)$(tput sgr0)
<a name="main.command-133"></a>
<a name="main.command-134"></a>$(tput bold)$(printf &quot;%s\n&quot; $branches | awk &#39;{printf(&quot;%01d %s\n&quot;, NR, $0)}&#39; | awk &#39;{$1=$1}1&#39; OFS=&quot;\t&quot;)$(tput sgr0)
<a name="main.command-135"></a>
<a name="main.command-136"></a>$(tput bold)$(tput setaf 1)(m)   main menu$(tput sgr0)
<a name="main.command-137"></a>$(tput bold)(q)   quit this compiler$(tput sgr0)
<a name="main.command-138"></a>
<a name="main.command-139"></a>Please enter branch number and press enter:
<a name="main.command-140"></a>EOF
<a name="main.command-141"></a>read input_variable
<a name="main.command-142"></a>i=$input_variable
<a name="main.command-143"></a>case &quot;$i&quot; in
<a name="main.command-144"></a>
<a name="main.command-145"></a>    &quot;q&quot;) 
<a name="main.command-146"></a>osascript -e &#39;tell application &quot;Terminal&quot; to close first window&#39; &amp; exit
<a name="main.command-147"></a>    ;;
<a name="main.command-148"></a>
<a name="main.command-149"></a>    &quot;m&quot;) 
<a name="main.command-150"></a>. &quot;$(cat /tmp/m_a_compath2)&quot;/main.command
<a name="main.command-151"></a>    ;;
<a name="main.command-152"></a>
<a name="main.command-153"></a>    &quot;$i&quot;) 
<a name="main.command-154"></a>/usr/bin/osascript -e &#39;tell application &quot;System Events&quot; to tell process &quot;Terminal&quot; to keystroke &quot;k&quot; using command down&#39;
<a name="main.command-155"></a>git checkout $(printf &quot;%s\n&quot; $branches | awk &#39;FNR == &quot;&#39;$i&#39;&quot;&#39;)
<a name="main.command-156"></a>. &quot;$(cat /tmp/m_a_compath2)&quot;/main.command
<a name="main.command-157"></a>    ;;
<a name="main.command-158"></a>
<a name="main.command-159"></a>    esac
<a name="main.command-160"></a>done
<a name="main.command-161"></a>
<a name="main.command-162"></a>    ;;
<a name="main.command-163"></a>
<a name="main.command-164"></a>    &quot;m&quot;) 
<a name="main.command-165"></a>echo &quot;cleaning!&quot;
<a name="main.command-166"></a>sleep 1
<a name="main.command-167"></a>cd ~/MLV-App-master/platform/qt/
<a name="main.command-168"></a>make clean 
<a name="main.command-169"></a>cd ~/MLV-App-master/platform/cocoa/
<a name="main.command-170"></a>make clean 
<a name="main.command-171"></a>cd ~/MLV-App-master/
<a name="main.command-172"></a>clear
<a name="main.command-173"></a>    ;;
<a name="main.command-174"></a>
<a name="main.command-175"></a>    &quot;q&quot;) 
<a name="main.command-176"></a>osascript -e &#39;tell application &quot;Terminal&quot; to close first window&#39; &amp; exit
<a name="main.command-177"></a>    ;;
<a name="main.command-178"></a>
<a name="main.command-179"></a>    esac
<a name="main.command-180"></a>done
<a name="main.command-181"></a>    ;;
<a name="main.command-182"></a>
<a name="main.command-183"></a>
<a name="main.command-184"></a>
<a name="main.command-185"></a>
</pre></div>
</td></tr></table>
    </div>
  


        </div>
        
      </div>
    </div>
  </div>
  
  <div data-module="source/set-changeset" data-hash="78e6acd69e79a156e1038e493fed984e351f8763"></div>



  
    
    
    
  
  

  </div>

        
        
        
      </div>
    </div>
  </div>

      </div>
    </div>
  
</div>

<div id="adg3-dialog"></div>


  

<div data-module="components/mentions/index">
  
    
    
  
  
    
    
  
  
    
    
  
</div>
<div data-module="components/typeahead/emoji/index">
  
    
    
  
</div>

<div data-module="components/repo-typeahead/index">
  
    
    
  
</div>

    
    
  

    
    
  

    
    
  

    
    
  


  


    
    
  

    
    
  



  
  
  <aui-inline-dialog
    id="help-menu-dialog"
    data-aui-alignment="bottom right"

    
    data-aui-alignment-static="true"
    data-module="header/help-menu"
    responds-to="toggle"
    aria-hidden="true">

  <div id="help-menu-section">
    <h1 class="help-menu-heading">Help</h1>

    <form id="help-menu-search-form" class="aui" target="_blank" method="get"
        action="https://support.atlassian.com/customer/search">
      <span id="help-menu-search-icon" class="aui-icon aui-icon-large aui-iconfont-search"></span>
      <input id="help-menu-search-form-input" name="q" class="text" type="text" placeholder="Ask a question">
    </form>

    <ul id="help-menu-links">
      <li>
        <a class="support-ga" data-support-gaq-page="DocumentationHome"
            href="https://confluence.atlassian.com/x/bgozDQ" target="_blank">
          Online help
        </a>
      </li>
      <li>
        <a class="support-ga" data-support-gaq-page="GitTutorials"
            href="https://www.atlassian.com/git?utm_source=bitbucket&amp;utm_medium=link&amp;utm_campaign=help_dropdown&amp;utm_content=learn_git"
            target="_blank">
          Learn Git
        </a>
      </li>
      <li>
        <a id="keyboard-shortcuts-link"
           href="#">Keyboard shortcuts</a>
      </li>
      <li>
        <a class="support-ga" data-support-gaq-page="DocumentationTutorials"
            href="https://confluence.atlassian.com/x/Q4sFLQ" target="_blank">
          Bitbucket tutorials
        </a>
      </li>
      <li>
        <a class="support-ga" data-support-gaq-page="SiteStatus"
            href="https://status.bitbucket.org/" target="_blank">
          Site status
        </a>
      </li>
      <li>
        <a class="support-ga" data-support-gaq-page="Home"
            href="https://support.atlassian.com/bitbucket-cloud/" target="_blank">
          Support
        </a>
      </li>
    </ul>
  </div>
</aui-inline-dialog>
  






  

  <div class="_mustache-templates">
    
      <script id="branch-checkout-template" type="text/html">
        

<div id="checkout-branch-contents">
  <div class="command-line">
    <p>
      Check out this branch on your local machine to begin working on it.
    </p>
    <input type="text" class="checkout-command" readonly="readonly"
        
          value="hg pull && hg update [[branchName]]"
        
        >
  </div>
  
    <div class="sourcetree-callout clone-in-sourcetree"
  data-module="components/clone/clone-in-sourcetree"
  data-https-url="https://bitbucket.org/Dannephoto/mlv_app_compiler"
  data-ssh-url="ssh://hg@bitbucket.org/Dannephoto/mlv_app_compiler">

  <div>
    <button class="aui-button aui-button-primary">
      
        Check out in Sourcetree
      
    </button>
  </div>

  <p class="windows-text">
    
      <a href="http://www.sourcetreeapp.com/?utm_source=internal&amp;utm_medium=link&amp;utm_campaign=clone_repo_win" target="_blank">Atlassian Sourcetree</a>
      is a free Git and Mercurial client for Windows.
    
  </p>
  <p class="mac-text">
    
      <a href="http://www.sourcetreeapp.com/?utm_source=internal&amp;utm_medium=link&amp;utm_campaign=clone_repo_mac" target="_blank">Atlassian Sourcetree</a>
      is a free Git and Mercurial client for Mac.
    
  </p>
</div>
  
</div>

      </script>
    
      <script id="branch-dialog-template" type="text/html">
        

<div class="tabbed-filter-widget branch-dialog">
  <div class="tabbed-filter">
    <input placeholder="Filter branches" class="filter-box" autosave="branch-dropdown-34067892" type="text">
    [[^ignoreTags]]
      <div class="aui-tabs horizontal-tabs aui-tabs-disabled filter-tabs">
        <ul class="tabs-menu">
          <li class="menu-item active-tab"><a href="#branches">Branches</a></li>
          <li class="menu-item"><a href="#tags">Tags</a></li>
        </ul>
      </div>
    [[/ignoreTags]]
  </div>
  
    <div class="tab-pane active-pane" id="branches" data-filter-placeholder="Filter branches">
      <ol class="filter-list">
        <li class="empty-msg">No matching branches</li>
        [[#branches]]
          
            [[#hasMultipleHeads]]
              [[#heads]]
                <li class="comprev filter-item">
                  <a class="pjax-trigger filter-item-link" href="/Dannephoto/mlv_app_compiler/src/[[changeset]]/Mlv_App_compiler.app/Contents/main.command?at=[[safeName]]"
                     title="[[name]]">
                    [[name]] ([[shortChangeset]])
                  </a>
                </li>
              [[/heads]]
            [[/hasMultipleHeads]]
            [[^hasMultipleHeads]]
              <li class="comprev filter-item">
                <a class="pjax-trigger filter-item-link" href="/Dannephoto/mlv_app_compiler/src/[[changeset]]/Mlv_App_compiler.app/Contents/main.command?at=[[safeName]]" title="[[name]]">
                  [[name]]
                </a>
              </li>
            [[/hasMultipleHeads]]
          
        [[/branches]]
      </ol>
    </div>
    <div class="tab-pane" id="tags" data-filter-placeholder="Filter tags">
      <ol class="filter-list">
        <li class="empty-msg">No matching tags</li>
        [[#tags]]
          <li class="comprev filter-item">
            <a class="pjax-trigger filter-item-link" href="/Dannephoto/mlv_app_compiler/src/[[changeset]]/Mlv_App_compiler.app/Contents/main.command?at=[[safeName]]" title="[[name]]">
              [[name]]
            </a>
          </li>
        [[/tags]]
      </ol>
    </div>
  
</div>

      </script>
    
      <script id="mention-result" type="text/html">
        
<span class="mention-result">
  <span class="aui-avatar aui-avatar-small mention-result--avatar">
    <span class="aui-avatar-inner">
      <img src="[[avatar_url]]">
    </span>
  </span>
  [[#display_name]]
    <span class="display-name mention-result--display-name">[[&display_name]]</span> <small class="username mention-result--username">[[&username]]</small>
  [[/display_name]]
  [[^display_name]]
    <span class="username mention-result--username">[[&username]]</span>
  [[/display_name]]
  [[#is_teammate]][[^is_team]]
    <span class="aui-lozenge aui-lozenge-complete aui-lozenge-subtle mention-result--lozenge">teammate</span>
  [[/is_team]][[/is_teammate]]
</span>
      </script>
    
      <script id="mention-call-to-action" type="text/html">
        
[[^query]]
<li class="bb-typeahead-item">Begin typing to search for a user</li>
[[/query]]
[[#query]]
<li class="bb-typeahead-item">Continue typing to search for a user</li>
[[/query]]

      </script>
    
      <script id="mention-no-results" type="text/html">
        
[[^searching]]
<li class="bb-typeahead-item">Found no matching users for <em>[[query]]</em>.</li>
[[/searching]]
[[#searching]]
<li class="bb-typeahead-item bb-typeahead-searching">Searching for <em>[[query]]</em>.</li>
[[/searching]]

      </script>
    
      <script id="emoji-result" type="text/html">
        
<span class="emoji-result">
  <span class="emoji-result--avatar">
    <img class="emoji" src="[[src]]">
  </span>
  <span class="name emoji-result--name">[[&name]]</span>
</span>

      </script>
    
      <script id="repo-typeahead-result" type="text/html">
        <span class="aui-avatar aui-avatar-project aui-avatar-xsmall">
  <span class="aui-avatar-inner">
    <img src="[[avatar]]">
  </span>
</span>
<span class="owner">[[&owner]]</span>/<span class="slug">[[&slug]]</span>

      </script>
    
      <script id="share-form-template" type="text/html">
        

<div class="error aui-message hidden">
  <span class="aui-icon icon-error"></span>
  <div class="message"></div>
</div>
<form class="aui">
  <table class="widget bb-list aui">
    <thead>
    <tr class="assistive">
      <th class="user">User</th>
      <th class="role">Role</th>
      <th class="actions">Actions</th>
    </tr>
    </thead>
    <tbody>
      <tr class="form">
        <td colspan="2">
          <input type="text" class="text bb-user-typeahead user-or-email"
                 placeholder="Username or email address"
                 autocomplete="off"
                 data-bb-typeahead-focus="false"
                 [[#disabled]]disabled[[/disabled]]>
        </td>
        <td class="actions">
          <button type="submit" class="aui-button aui-button-light" disabled>Add</button>
        </td>
      </tr>
    </tbody>
  </table>
</form>

      </script>
    
      <script id="share-detail-template" type="text/html">
        

[[#username]]
<td class="user
    [[#hasCustomGroups]]custom-groups[[/hasCustomGroups]]"
    [[#error]]data-error="[[error]]"[[/error]]>
  <div title="[[displayName]]">
    <a href="/[[username]]/" class="user">
      <span class="aui-avatar aui-avatar-xsmall">
        <span class="aui-avatar-inner">
          <img src="[[avatar]]">
        </span>
      </span>
      <span>[[displayName]]</span>
    </a>
  </div>
</td>
[[/username]]
[[^username]]
<td class="email
    [[#hasCustomGroups]]custom-groups[[/hasCustomGroups]]"
    [[#error]]data-error="[[error]]"[[/error]]>
  <div title="[[email]]">
    <span class="aui-icon aui-icon-small aui-iconfont-email"></span>
    [[email]]
  </div>
</td>
[[/username]]
<td class="role
    [[#hasCustomGroups]]custom-groups[[/hasCustomGroups]]">
  <div>
    [[#group]]
      [[#hasCustomGroups]]
        <select class="group [[#noGroupChoices]]hidden[[/noGroupChoices]]">
          [[#groups]]
            <option value="[[slug]]"
                [[#isSelected]]selected[[/isSelected]]>
              [[name]]
            </option>
          [[/groups]]
        </select>
      [[/hasCustomGroups]]
      [[^hasCustomGroups]]
      <label>
        <input type="checkbox" class="admin"
            [[#isAdmin]]checked[[/isAdmin]]>
        Administrator
      </label>
      [[/hasCustomGroups]]
    [[/group]]
    [[^group]]
      <ul>
        <li class="permission aui-lozenge aui-lozenge-complete
            [[^read]]aui-lozenge-subtle[[/read]]"
            data-permission="read">
          read
        </li>
        <li class="permission aui-lozenge aui-lozenge-complete
            [[^write]]aui-lozenge-subtle[[/write]]"
            data-permission="write">
          write
        </li>
        <li class="permission aui-lozenge aui-lozenge-complete
            [[^admin]]aui-lozenge-subtle[[/admin]]"
            data-permission="admin">
          admin
        </li>
      </ul>
    [[/group]]
  </div>
</td>
<td class="actions
    [[#hasCustomGroups]]custom-groups[[/hasCustomGroups]]">
  <div>
    <a href="#" class="delete">
      <span class="aui-icon aui-icon-small aui-iconfont-remove">Delete</span>
    </a>
  </div>
</td>

      </script>
    
      <script id="share-team-template" type="text/html">
        

<div class="clearfix">
  <span class="team-avatar-container">
    <span class="aui-avatar aui-avatar-medium">
      <span class="aui-avatar-inner">
        <img src="[[avatar]]">
      </span>
    </span>
  </span>
  <span class="team-name-container">
    [[display_name]]
  </span>
</div>
<p class="helptext">
  
    Existing users are granted access to this team immediately.
    New users will be sent an invitation.
  
</p>
<div class="share-form"></div>

      </script>
    
      <script id="scope-list-template" type="text/html">
        <ul class="scope-list">
  [[#scopes]]
    <li class="scope-list--item">
      <span class="scope-list--icon aui-icon aui-icon-small [[icon]]"></span>
      <span class="scope-list--description">[[description]]</span>
    </li>
  [[/scopes]]
</ul>

      </script>
    
      <script id="source-changeset" type="text/html">
        

<a href="/Dannephoto/mlv_app_compiler/src/[[raw_node]]/[[path]]?at=default"
    class="[[#selected]]highlight[[/selected]]"
    data-hash="[[node]]">
  [[#author.username]]
    <span class="aui-avatar aui-avatar-xsmall">
      <span class="aui-avatar-inner">
        <img src="[[author.avatar]]">
      </span>
    </span>
    <span class="author" title="[[raw_author]]">[[author.display_name]]</span>
  [[/author.username]]
  [[^author.username]]
    <span class="aui-avatar aui-avatar-xsmall">
      <span class="aui-avatar-inner">
        <img src="https://d301sr5gafysq2.cloudfront.net/3b14e1f927c2/img/default_avatar/user_blue.svg">
      </span>
    </span>
    <span class="author unmapped" title="[[raw_author]]">[[author]]</span>
  [[/author.username]]
  <time datetime="[[utctimestamp]]" data-title="true">[[utctimestamp]]</time>
  <span class="message">[[message]]</span>
</a>

      </script>
    
      <script id="embed-template" type="text/html">
        

<form class="aui inline-dialog-embed-dialog">
  <label for="embed-code-[[dialogId]]">Embed this source in another page:</label>
  <input type="text" readonly="true" value="&lt;script src=&quot;[[url]]&quot;&gt;&lt;/script&gt;" id="embed-code-[[dialogId]]" class="embed-code">
</form>

      </script>
    
  </div>




  
  


<script nonce="">
  window.__initial_state__ = {"section": {"repository": {"connectActions": [], "cloneProtocol": "https", "currentRepository": {"scm": "hg", "website": "", "name": "mlv_app_compiler", "language": "", "description": "", "links": {"clone": [{"href": "https://bitbucket.org/Dannephoto/mlv_app_compiler", "name": "https"}, {"href": "ssh://hg@bitbucket.org/Dannephoto/mlv_app_compiler", "name": "ssh"}], "self": {"href": "https://bitbucket.org/!api/2.0/repositories/Dannephoto/mlv_app_compiler"}, "html": {"href": "https://bitbucket.org/Dannephoto/mlv_app_compiler"}, "avatar": {"href": "https://bytebucket.org/ravatar/%7Bab93a1b6-abba-4dda-98c1-23111e57e84b%7D?ts=default"}}, "mainbranch": {"name": "default"}, "full_name": "Dannephoto/mlv_app_compiler", "owner": {"username": "Dannephoto", "website": null, "display_name": "danne", "account_id": "557058:4093b985-8025-4fe0-a874-b194cf35f37c", "links": {"self": {"href": "https://bitbucket.org/!api/2.0/users/Dannephoto"}, "html": {"href": "https://bitbucket.org/Dannephoto/"}, "avatar": {"href": "https://bitbucket.org/account/Dannephoto/avatar/32/"}}, "created_on": "2013-12-18T14:22:09.800590+00:00", "is_staff": false, "location": null, "type": "user", "uuid": "{a62aa76c-79ee-415b-8891-5c4c5893288e}"}, "type": "repository", "slug": "mlv_app_compiler", "is_private": false, "uuid": "{ab93a1b6-abba-4dda-98c1-23111e57e84b}"}, "menuItems": [{"analytics_label": "repository.overview", "is_client_link": false, "icon_class": "icon-overview", "badge_label": null, "weight": 100, "url": "/Dannephoto/mlv_app_compiler/overview", "tab_name": "overview", "can_display": true, "label": "Overview", "type": "menu_item", "anchor": true, "analytics_payload": {}, "matching_url_prefixes": [], "target": "_self", "id": "repo-overview-link", "icon": "icon-overview"}, {"analytics_label": "repository.source", "is_client_link": false, "icon_class": "icon-source", "badge_label": null, "weight": 200, "url": "/Dannephoto/mlv_app_compiler/src", "tab_name": "source", "can_display": true, "label": "Source", "type": "menu_item", "anchor": true, "analytics_payload": {}, "matching_url_prefixes": ["/diff", "/history-node"], "target": "_self", "id": "repo-source-link", "icon": "icon-source"}, {"analytics_label": "repository.commits", "is_client_link": false, "icon_class": "icon-commits", "badge_label": null, "weight": 300, "url": "/Dannephoto/mlv_app_compiler/commits/", "tab_name": "commits", "can_display": true, "label": "Commits", "type": "menu_item", "anchor": true, "analytics_payload": {}, "matching_url_prefixes": [], "target": "_self", "id": "repo-commits-link", "icon": "icon-commits"}, {"analytics_label": "repository.branches", "is_client_link": false, "icon_class": "icon-branches", "badge_label": null, "weight": 400, "url": "/Dannephoto/mlv_app_compiler/branches/", "tab_name": "branches", "can_display": true, "label": "Branches", "type": "menu_item", "anchor": true, "analytics_payload": {}, "matching_url_prefixes": [], "target": "_self", "id": "repo-branches-link", "icon": "icon-branches"}, {"analytics_label": "repository.pullrequests", "is_client_link": false, "icon_class": "icon-pull-requests", "badge_label": null, "weight": 500, "url": "/Dannephoto/mlv_app_compiler/pull-requests/", "tab_name": "pullrequests", "can_display": true, "label": "Pull requests", "type": "menu_item", "anchor": true, "analytics_payload": {}, "matching_url_prefixes": [], "target": "_self", "id": "repo-pullrequests-link", "icon": "icon-pull-requests"}, {"analytics_label": "user.addon", "is_client_link": false, "icon_class": "aui-iconfont-build", "badge_label": null, "weight": 550, "url": "/Dannephoto/mlv_app_compiler/addon/pipelines/home", "tab_name": "repopage-KAzka9-add-on-link", "can_display": true, "label": "Pipelines", "icon_url": null, "anchor": true, "analytics_payload": {}, "matching_url_prefixes": [], "type": "connect_menu_item", "id": "repopage-KAzka9-add-on-link", "target": "_self"}, {"analytics_label": "repository.downloads", "is_client_link": false, "icon_class": "icon-downloads", "badge_label": null, "weight": 800, "url": "/Dannephoto/mlv_app_compiler/downloads/", "tab_name": "downloads", "can_display": true, "label": "Downloads", "type": "menu_item", "anchor": true, "analytics_payload": {}, "matching_url_prefixes": [], "target": "_self", "id": "repo-downloads-link", "icon": "icon-downloads"}], "bitbucketActions": [{"analytics_label": "repository.clone", "is_client_link": false, "icon_class": "icon-clone", "badge_label": null, "weight": 100, "url": "#clone", "tab_name": "clone", "can_display": true, "label": "<strong>Clone<\/strong> this repository", "type": "menu_item", "anchor": true, "analytics_payload": {}, "matching_url_prefixes": [], "target": "_self", "id": "repo-clone-button", "icon": "icon-clone"}, {"analytics_label": "repository.compare", "is_client_link": false, "icon_class": "aui-icon-small aui-iconfont-devtools-compare", "badge_label": null, "weight": 400, "url": "/Dannephoto/mlv_app_compiler/branches/compare", "tab_name": "compare", "can_display": true, "label": "<strong>Compare<\/strong> branches or tags", "type": "menu_item", "anchor": true, "analytics_payload": {}, "matching_url_prefixes": [], "target": "_self", "id": "repo-compare-link", "icon": "aui-icon-small aui-iconfont-devtools-compare"}, {"analytics_label": "repository.fork", "is_client_link": false, "icon_class": "icon-fork", "badge_label": null, "weight": 500, "url": "/Dannephoto/mlv_app_compiler/fork", "tab_name": "fork", "can_display": true, "label": "<strong>Fork<\/strong> this repository", "type": "menu_item", "anchor": true, "analytics_payload": {}, "matching_url_prefixes": [], "target": "_self", "id": "repo-fork-link", "icon": "icon-fork"}], "activeMenuItem": "source"}}, "global": {"needs_marketing_consent": false, "features": {"exp-share-to-invite-variation": false, "bitbucket-chats-integration": true, "source-browser-file-filter": true, "cache-ref-adverts": true, "xcode-clone-dialog-button": true, "mobile-nav": true, "deployments": true, "fe_word_diff": true, "use-moneybucket": true, "default-merge-strategy": true, "analytics_push_introspection": true, "connect-v5": true, "nav-add-file": false, "clone-in-xcode": true, "gdpr-marketing-consent": true, "ravatar": true, "trello-boards": true, "src-lastmod-for-dirs": true, "search-syntax-highlighting": true, "app-passwords": true, "lfs_post_beta": true, "allow-pullrequest-live-reviewers": true}, "locale": "en", "geoip_country": null, "targetFeatures": {"new-code-review-experiment": false, "show-guidance-message": true, "search-satisfaction": true, "bitbucket-chats-integration": true, "source-browser-file-filter": true, "cache-ref-adverts": true, "xcode-clone-dialog-button": true, "mobile-nav": true, "deployments": true, "fe_word_diff": true, "clonebundles": true, "use-moneybucket": true, "default-merge-strategy": true, "analytics_push_introspection": true, "ravatar": true, "diff-api-renames": false, "clone-in-xcode": true, "gdpr-marketing-consent": true, "connect-v5": true, "trello-boards": true, "atlassian-editor": true, "src-lastmod-for-dirs": true, "new-source-browser": true, "exp-new-user-survey": true, "evolution": false, "search-syntax-highlighting": true, "app-passwords": true, "lfs_post_beta": true, "allow-pullrequest-live-reviewers": true}, "isFocusedTask": false, "targetUser": {"username": "Dannephoto", "website": null, "display_name": "danne", "account_id": "557058:4093b985-8025-4fe0-a874-b194cf35f37c", "links": {"self": {"href": "https://bitbucket.org/!api/2.0/users/Dannephoto"}, "html": {"href": "https://bitbucket.org/Dannephoto/"}, "avatar": {"href": "https://bitbucket.org/account/Dannephoto/avatar/32/"}}, "created_on": "2013-12-18T14:22:09.800590+00:00", "is_staff": false, "location": null, "type": "user", "uuid": "{a62aa76c-79ee-415b-8891-5c4c5893288e}"}, "flags": [], "isNavigationOpen": true, "path": "/Dannephoto/mlv_app_compiler/src/default/Mlv_App_compiler.app/Contents/main.command", "focusedTaskBackButtonUrl": null}};
  window.__settings__ = {"MARKETPLACE_TERMS_OF_USE_URL": null, "JIRA_ISSUE_COLLECTORS": {"source-browser": {"url": "https://bitbucketfeedback.atlassian.net/s/d41d8cd98f00b204e9800998ecf8427e-T/-tqnsjm/b/20/a44af77267a987a660377e5c46e0fb64/_/download/batch/com.atlassian.jira.collector.plugin.jira-issue-collector-plugin:issuecollector/com.atlassian.jira.collector.plugin.jira-issue-collector-plugin:issuecollector.js?locale=en-US&collectorId=c19c2ff6", "id": "c19c2ff6"}, "code-review": {"url": "https://bitbucketfeedback.atlassian.net/s/d41d8cd98f00b204e9800998ecf8427e-T/-4bqv2z/b/20/a44af77267a987a660377e5c46e0fb64/_/download/batch/com.atlassian.jira.collector.plugin.jira-issue-collector-plugin:issuecollector/com.atlassian.jira.collector.plugin.jira-issue-collector-plugin:issuecollector.js?locale=en-US&collectorId=bb066400", "id": "bb066400"}}, "CANON_URL": "https://bitbucket.org", "CONSENT_HUB_FRONTEND_BASE_URL": "https://preferences.atlassian.com", "API_CANON_URL": "https://api.bitbucket.org", "SOCIAL_AUTH_ATLASSIANID_LOGOUT_URL": "https://id.atlassian.com/logout"};
  window.__webpack_nonce__ = '';
</script>

<script src="https://d301sr5gafysq2.cloudfront.net/3b14e1f927c2/jsi18n/en/djangojs.js" nonce=""></script>

  <script src="https://d301sr5gafysq2.cloudfront.net/3b14e1f927c2/dist/webpack/locales/en.js" nonce=""></script>

<script src="https://d301sr5gafysq2.cloudfront.net/3b14e1f927c2/dist/webpack/vendor.js" nonce=""></script>
<script src="https://d301sr5gafysq2.cloudfront.net/3b14e1f927c2/dist/webpack/app.js" nonce=""></script>


<script async src="https://www.google-analytics.com/analytics.js" nonce=""></script>

<script nonce="" type="text/javascript">window.NREUM||(NREUM={});NREUM.info={"beacon":"bam.nr-data.net","queueTime":0,"licenseKey":"a2cef8c3d3","agent":"","transactionName":"Z11RZxdWW0cEVkYLDV4XdUYLVEFdClsdAAtEWkZQDlJBGgRFQhFMQl1DXFcZQ10AQkFYBFlUVlEXWEJHAA==","applicationID":"1841284","errorBeacon":"bam.nr-data.net","applicationTime":886}</script>
</body>
</html>