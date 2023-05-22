import { saveAs } from 'file-saver'

export function zip(data, zipName) {
  const blob = new Blob([data], { type: 'application/zip' })
  saveAs(blob, zipName)
}
